//
//  Planets.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/3/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation

struct Planets: Decodable {
    let count: Int
    let next: URL?
    var results: [Planet]
}

struct Planet: Decodable, CustomStringConvertible {

    var description: String {
        return name
    }

    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [URL]
    let films: [URL]
    let created: Date
    let edited: Date
    let url: URL
}
