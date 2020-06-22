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

enum QueryType: String {
    case people
    case planets
    case vehicles
    case starships
    case films
}

enum QueryItem: Hashable, CustomStringConvertible {
    case person(Person)
    case planet(Planet)
    case vehicle(Vehicle)
    case starship(Starship)
    case film(Film)
    
    var description: String {
        switch self {
        case .person(let item):
            return item.name
        case .planet(let item):
            return item.name
        case .vehicle(let item):
            return item.name
        case .starship(let item):
            return item.name
        case .film(let item):
            return item.title
        }
    }
}

struct NetworkController {
    let session: JSONSession
    var cached = [[QueryItem]](repeating: [], count: 5)
    
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
    
    func search<T: Decodable>(queryType: T.Type, filter: String, page: Int) throws -> T {
        let request = JSONRequest<T, ErrorResponse>(
            method: .get,
            path: "\(String(describing: String(describing: queryType).lowercased()))/",
            session: session
        )
        return try request.perform(parameters: ["search": filter, "page": String(page)]).await()
    }
    
    mutating func search(selectedScope: Int, filter: String, page: Int) throws -> (Int, [QueryItem]) {
        switch selectedScope {
        case 0:
            guard cached[selectedScope].isEmpty else {
                return (cached[selectedScope].count, cached[selectedScope])
            }
            var result = try search(queryType: People.self, filter: filter, page: page)
            var nextResult = result
            var page = 1
            while result.results.count < result.count {
                nextResult = try search(queryType: People.self, filter: filter, page: page)
                result.results += nextResult.results
                page += 1
            }
            var prev = ""
            result.results = result.results.sorted { $0.name < $1.name }.filter {
                let result = prev != $0.name
                prev = $0.name
                return result
            }
            let final = result.results.map { QueryItem.person($0) }
            cached[selectedScope] = final
            return (result.count, final)
        case 1:
            guard cached[selectedScope].isEmpty else {
                return (cached[selectedScope].count, cached[selectedScope])
            }
            var result = try search(queryType: Planets.self, filter: filter, page: page)
            var nextResult = result
            var page = 1
            while result.results.count < result.count {
                nextResult = try search(queryType: Planets.self, filter: filter, page: page)
                result.results += nextResult.results
                page += 1
            }
            var prev = ""
            result.results = result.results.sorted { $0.name < $1.name }.filter {
                let result = prev != $0.name
                prev = $0.name
                return result
            }
            result.results.sort { $0.name < $1.name }
            let final = result.results.map { QueryItem.planet($0) }
            cached[selectedScope] = final
            return (result.count, final)
        case 2:
            guard cached[selectedScope].isEmpty else {
                return (cached[selectedScope].count, cached[selectedScope])
            }
            var result = try search(queryType: Films.self, filter: filter, page: page)
            var nextResult = result
            var page = 1
            while result.results.count < result.count {
                nextResult = try search(queryType: Films.self, filter: filter, page: page)
                result.results += nextResult.results
                page += 1
            }
            var prev = ""
            result.results = result.results.sorted { $0.title < $1.title }.filter {
                let result = prev != $0.title
                prev = $0.title
                return result
            }
            result.results.sort { $0.title < $1.title }
            let final = result.results.map { QueryItem.film($0) }
            cached[selectedScope] = final
            return (result.count, final)
        case 3:
            guard cached[selectedScope].isEmpty else {
                return (cached[selectedScope].count, cached[selectedScope])
            }
            var result = try search(queryType: Vehicles.self, filter: filter, page: page)
            var nextResult = result
            var page = 1
            while result.results.count < result.count {
                nextResult = try search(queryType: Vehicles.self, filter: filter, page: page)
                result.results += nextResult.results
                page += 1
            }
            var prev = ""
            result.results = result.results.sorted { $0.name < $1.name }.filter {
                let result = prev != $0.name
                prev = $0.name
                return result
            }
            result.results.sort { $0.name < $1.name }
            let final = result.results.map { QueryItem.vehicle($0) }
            cached[selectedScope] = final
            return (result.count, final)
        case 4:
            guard cached[selectedScope].isEmpty else {
                return (cached[selectedScope].count, cached[selectedScope])
            }
            var result = try search(queryType: Starships.self, filter: filter, page: page)
            var nextResult = result
            var page = 1
            while result.results.count < result.count {
                nextResult = try search(queryType: Starships.self, filter: filter, page: page)
                result.results += nextResult.results
                page += 1
            }
            var prev = ""
            result.results = result.results.sorted { $0.name < $1.name }.filter {
                let result = prev != $0.name
                prev = $0.name
                return result
            }
            result.results.sort { $0.name < $1.name }
            let final = result.results.map { QueryItem.starship($0) }
            cached[selectedScope] = final
            return (result.count, final)
        default: fatalError()
        }
    }
}

