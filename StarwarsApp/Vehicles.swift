//
//  Vehicles.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/3/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation

struct Vehicles: Decodable {
    let count: Int
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
