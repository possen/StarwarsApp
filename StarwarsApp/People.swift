//
//  People.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/3/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation

struct People: Decodable {
    var count: Int
    let next: URL?
    var results: [Person]
}

struct Person: Decodable, CustomStringConvertible, Hashable {
    
    var description: String {
        return name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case birthYear
        case eyeColor
        case height
        case mass
        case skinColor
        case homeworld
        case films
        case species
        case starships
        case vehicles
        case created
        case edited
        case url
    }
 
    private let identifier = UUID()
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
