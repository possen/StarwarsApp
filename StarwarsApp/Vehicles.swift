//
//  Vehicles.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/3/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation

struct Vehicles: Decodable {
    var count: Int
    let next: URL?
    var results: [Vehicle]
}

struct Vehicle: Decodable, CustomStringConvertible, Hashable {

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
        case vehicleClass
        case manufacturer
        case length
        case costInCredits
        case crew
        case passengers
        case maxAtmospheringSpeed
        case cargoCapacity
        case pilots
        case films
        case created
        case edited
        case url
    }
    
    let name: String
    let model: String
    let vehicleClass: String
    let manufacturer: String
    let length: String
    let costInCredits: String
    let crew: String
    let passengers: String
    let maxAtmospheringSpeed: String
    let cargoCapacity: String
    let pilots: [URL]
    let films: [URL]
    let created: Date
    let edited: Date
    let url: URL
}
