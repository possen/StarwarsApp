//
//  Film.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/3/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation

struct Films: Decodable {
    let count: Int
    let next: URL?
    var results: [Film]
}

struct Film: Decodable, CustomStringConvertible, Hashable {
    var description: String {
        return title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }
    private let identifier = UUID()
    
    let title: String
    let episodeId: Int
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let species: [URL]
    let starships: [URL]
    let vehicles: [URL]
    let characters: [URL]
    let planets: [URL]
    let created: Date
    let edited: Date
    let url: URL
}
