//
//  People.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/3/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation

struct People: Decodable {
    let count: Int
    let next: URL?
    var results: [Person]
}

struct Person: Decodable, CustomStringConvertible {
    
    var description: String {
        return name
    }
    
    let name: String
    let birthYear: String
    let eyeColor: String
    let height: String
    let mass: String
    let skinColor: String
    let homeworld: URL
    let films: [URL]
    let species: [URL]
    let starships: [URL]
    let vehicles: [URL]
    let created: Date
    let edited: Date
    let url: URL
}
