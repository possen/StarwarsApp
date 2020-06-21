//
//  NetworkController.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/2/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import ResonanceKit
import Foundation

struct ErrorResponse: Decodable, CustomStringConvertible {
    
    var description: String {
        "error"
    }
}

struct NetworkController {
    let session: JSONSession
    
    public enum Failures: Error {
        case badDateFormat
    }

    public static var dateFormatter: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withFullDate,
            .withTime,
            .withDashSeparatorInDate,
            .withColonSeparatorInTime
        ]
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // TODO: double check this.
        return formatter
    }
    
    public static func specialDateDecoder(decoder: Decoder) throws -> Date {
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        guard let val = Self.dateFormatter.date(from: dateString) else {
            throw Failures.badDateFormat
        }
        return val
    }


    init() {
        guard let url = URL(string: "https://swapi.dev/api/") else {
            fatalError("unable to create URL")
        }
        self.session = JSONSession(baseURL: url)
        session.keyDecodingStrategy = .convertFromSnakeCase
        session.dateDecodingStrategy = .custom(Self.specialDateDecoder)
    }
    
    struct GenericResult {
        let totalCount: Int
        let results: [Any]
    }
    
    func search(query: String, filter: String, page: Int) throws -> GenericResult {
                
        func fetchPeople(filter: String, page: Int) throws -> People {
            let request = JSONRequest<People, ErrorResponse>(method: .get, path: query, session: self.session)
            return try request.perform(parameters: ["search": filter, "page": String(page)]).await()
        }
        
        func fetchPlanets(filter: String, page: Int) throws -> Planets {
            let request = JSONRequest<Planets, ErrorResponse>(method: .get, path: query, session: self.session)
            return try request.perform(parameters: ["search": filter, "page": String(page)]).await()
        }
        
        func fetchFilms(filter: String, page: Int) throws -> Films {
            let request = JSONRequest<Films, ErrorResponse>(method: .get, path: query, session: self.session)
            return try request.perform(parameters: ["search": filter, "page": String(page)]).await()
        }
        
        func fetchVehicles(filter: String, page: Int) throws -> Vehicles {
            let request = JSONRequest<Vehicles, ErrorResponse>(method: .get, path: query, session: self.session)
            return try request.perform(parameters: ["search": filter, "page": String(page)]).await()
        }
        
        func fetchStarships(filter: String, page: Int) throws -> Starships {
            let request = JSONRequest<Starships, ErrorResponse>(method: .get, path: query, session: self.session)
            return try request.perform(parameters: ["search": filter, "page": String(page)]).await()
        }

        switch query {
        case "people/":
            let people = try fetchPeople(filter: filter, page: page)
            return GenericResult(totalCount: people.count, results: people.results)
        case "planets/":
            let planets = try fetchPlanets(filter: filter, page: page)
            return GenericResult(totalCount: planets.count, results: planets.results)
        case "films/":
            let films = try fetchFilms(filter: filter, page: page)
            return GenericResult(totalCount: films.count, results: films.results)
        case "vehicles/":
            let vehicles = try fetchVehicles(filter: filter, page: page)
            return GenericResult(totalCount: vehicles.count, results: vehicles.results)
        case "starships/":
            let starships = try fetchStarships(filter: filter, page: page)
            return GenericResult(totalCount: starships.count, results: starships.results)
        default:
            fatalError("unsupported data type")
        }
    }
}

