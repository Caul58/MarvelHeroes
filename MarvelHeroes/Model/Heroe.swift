//
//  Heroe.swift
//  MarvelHeroes
//
//  Created by CARLOS RAUL PEREZ MORENO on 9/8/17.
//  Copyright © 2017 CARLOS RAUL PEREZ MORENO. All rights reserved.
//

import UIKit

class Heroe: Person {

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
        
        self.name = dictionary[Heroe.name] as? String ?? ""
        self.photo = dictionary[Heroe.photo] as? String ?? ""
        self.power = dictionary[Heroe.power] as? String ?? ""
        self.abilities = dictionary[Heroe.abilities] as? String ?? ""
        self.groups = dictionary[Heroe.groups] as? String ?? ""
        super.init(dictionary)
        
    }
    
}
