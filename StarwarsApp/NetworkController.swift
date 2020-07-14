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

protocol Processor {
    func process(_ filter: String) throws -> (Int, [QueryItem])
}

struct NetworkController {
    let session: JSONSession
    var cached = [[QueryItem]](repeating: [], count: 5)
    var processors: [Processor] = []
    
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
        guard cached[selectedScope].isEmpty else {
            return (cached[selectedScope].count, cached[selectedScope])
        }
        let processor = processors[selectedScope]
        let (count, items) = try processor.process(filter)
        cached[selectedScope] = items
        return (count, items)
    }
}

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}

