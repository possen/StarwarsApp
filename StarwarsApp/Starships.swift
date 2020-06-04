//
//  Starships.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/3/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation

struct Starships: Decodable {
    let count: Int
    let next: URL?
    var results: [Starship]
}

struct Starship: Decodable, CustomStringConvertible {
    var description: String {
        return name
    }
    
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let crew: String
    let passengers: String
    let maxAtmospheringSpeed: String
    let hyperdriveRating: String
    let MGLT: String
    let cargoCapacity: String
    let consumables: String
    let films: [URL]
    let pilots: [URL]
    let created: Date
    let edited: Date
    let url: URL
}
