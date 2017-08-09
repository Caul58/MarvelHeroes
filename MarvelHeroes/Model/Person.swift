//
//  Person.swift
//  MarvelHeroes
//
//  Created by CARLOS RAUL PEREZ MORENO on 9/8/17.
//  Copyright © 2017 CARLOS RAUL PEREZ MORENO. All rights reserved.
//

import UIKit

class Person {

    fileprivate static let name: String = "realName"
    fileprivate static let height: String = "height"
    
    let aka: String
    let height: String
    
    init(_ dictionary: [String: Any]) {
        
        self.aka = dictionary[Person.name] as? String ?? ""
        self.height = dictionary[Person.height] as? String ?? ""
        
    }
    
    
}
