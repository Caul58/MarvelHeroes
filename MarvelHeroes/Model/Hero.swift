//
//  Heroe.swift
//  MarvelHeroes
//
//  Created by CARLOS RAUL PEREZ MORENO on 9/8/17.
//  Copyright © 2017 CARLOS RAUL PEREZ MORENO. All rights reserved.
//

import UIKit

class Hero: Person {

    fileprivate static let name: String = "name"
    fileprivate static let photo: String = "photo"
    fileprivate static let power: String = "power"
    fileprivate static let abilities: String = "abilities"
    fileprivate static let groups: String = "groups"
    
    var name: String
    var photo: String
    var photoURL: URL?{
        return URL(string: photo)
    }
    let power: String
    var abilities: String
    let groups: String
    
    override init(_ dictionary: [String: Any]) {
        
        self.name = dictionary[Hero.name] as? String ?? ""
        self.photo = dictionary[Hero.photo] as? String ?? ""
        self.power = dictionary[Hero.power] as? String ?? ""
        self.abilities = dictionary[Hero.abilities] as? String ?? ""
        self.groups = dictionary[Hero.groups] as? String ?? ""
        super.init(dictionary)
        
    }
    
}
