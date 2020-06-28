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

struct Starship: Decodable, CustomStringConvertible, Hashable {
    var description: String {
        return name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }
    
    private let identifier = UUID()

    enum CodingKeys: String, CodingKey {
        case name
        case model
        case manufacturer
        case costInCredits
        case length
        case crew
        case passengers
        case maxAtmospheringSpeed
        case hyperdriveRating
        case MGLT
        case cargoCapacity
        case consumables
        case films
        case pilots
        case created
        case edited
        case url
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
