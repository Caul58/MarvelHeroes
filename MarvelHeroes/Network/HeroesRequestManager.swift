//
//  RequestManager.swift
//  MarvelHeroes
//
//  Created by CARLOS RAUL PEREZ MORENO on 9/8/17.
//  Copyright © 2017 CARLOS RAUL PEREZ MORENO. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HeroesRequestManager {

    private static let heroURLString: String = "https://api.myjson.com/bins/bvyob"
    private static let mainObject: String = "superheroes"
    
    static func fetchHeroes(bag: DisposeBag, completion: @escaping (_ arrayHeroes:[Hero])->()) {
        
        DispatchQueue.global(qos: .background).async {
            
            let response = Observable.from([HeroesRequestManager.heroURLString])
                .map{ urlString -> URL in
                    return URL(string: urlString)!
                }
                .map { url -> URLRequest in
                    return URLRequest(url: url)
                }
                .flatMap { request -> Observable<(HTTPURLResponse, Data)> in
                    return URLSession.shared.rx.response(request: request)
                }.shareReplay(1)
            
            response
                .filter {response, _ in
                    return 200..<300 ~= response.statusCode
                }
                .map { _, data -> [[String: Any]] in
                    guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                    let result = (jsonObject as! [String: Any])[HeroesRequestManager.mainObject] as? [[String: Any]] else {
                            return []
                    }
                    return result
                }
                .filter { objects in
                    return objects.count > 0
                }
                .map { objects in
                    return objects.flatMap(Hero.init)
                }
                .subscribe(onNext: { newHeroes in
                    DispatchQueue.main.async {
                        completion(newHeroes)
                    }
                })
                .disposed(by: bag)
        
        }
    
    }
    
}
