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
    
    
    func search(query: String, filter: String, completion: @escaping ([Any]) -> Void) {

        func fixURL(_ url: URL?) -> URL? {
            var comp = URLComponents()
            comp.scheme = "https"
            comp.host = url?.host
            comp.path = url?.path ?? ""
            comp.query = url?.query
            return comp.url
        }
        
        // TODO: in a real app would not load all data, it would page on demand,
        // but since data is small and time is short, just going to load it all here
        // TODO: probably would like to figure out a way to reduce duplication here.
        // NOTE: this is being performed using a coroutine so it does not block main thread.
        
        func fetchPeople(filter: String) throws {
            let request = JSONRequest<People, ErrorResponse>(method: .get, path: query, session: self.session)
            var result = try request.perform(parameters: ["search": filter]).await()
            let nextResult = result
            while result.results.count < nextResult.count {
                guard let next = fixURL(nextResult.next) else {
                    break
                }
                let request = JSONRequest<People, ErrorResponse>(method: .get, path: query, session: self.session)
                let nextResult = try request.perform(url: next).await()
                result.results += nextResult.results
            }
            completion(result.results)
        }
        
        func fetchPlanets(filter: String) throws {
            let request = JSONRequest<Planets, ErrorResponse>(method: .get, path: query, session: self.session)
            var result = try request.perform(parameters: ["search": filter]).await()
            let nextResult = result
            while result.results.count < nextResult.count {
                guard let next = fixURL(result.next) else {
                    break
                }
                let request = JSONRequest<Planets, ErrorResponse>(method: .get, path: query, session: self.session)
                let nextResult = try request.perform(url: next).await()
                result.results += nextResult.results
            }
            completion(result.results)
        }
        
        func fetchFilms(filter: String) throws {
            let request = JSONRequest<Films, ErrorResponse>(method: .get, path: query, session: self.session)
            var result = try request.perform(parameters: ["search": filter]).await()
            let nextResult = result
            while result.results.count < nextResult.count {
                guard let next = fixURL(result.next) else {
                    break
                }
                let request = JSONRequest<Films, ErrorResponse>(method: .get, path: query, session: self.session)
                let nextResult = try request.perform(url: next).await()
                result.results += nextResult.results
            }
            completion(result.results)
        }
        
        func fetchVehicles(filter: String) throws {
            let request = JSONRequest<Vehicles, ErrorResponse>(method: .get, path: query, session: self.session)
            var result = try request.perform( parameters: ["search": filter]).await()
            let nextResult = result
            while result.results.count < nextResult.count {
                guard let next = fixURL(result.next) else {
                    break
                }
                let request = JSONRequest<Vehicles, ErrorResponse>(method: .get, path: query, session: self.session)
                let nextResult = try request.perform(url: next).await()
                result.results += nextResult.results
            }
            completion(result.results)
        }
        
        func fetchStarships(filter: String) throws {
            let request = JSONRequest<Starships, ErrorResponse>(method: .get, path: query, session: self.session)
            var result = try request.perform(parameters: ["search": filter]).await()
            let nextResult = result
            while result.results.count < nextResult.count {
                guard let next = fixURL(result.next) else {
                    break
                }
                let request = JSONRequest<Starships, ErrorResponse>(method: .get, path: query, session: self.session)
                let nextResult = try request.perform(url: next).await()
                result.results += nextResult.results
            }
            completion(result.results)
        }

        DispatchQueue.main.startCoroutine {
            do {
                switch query {
                case "people/":
                    try fetchPeople(filter: filter)
                case "planets/":
                    try fetchPlanets(filter: filter)
                case "films/":
                    try fetchFilms(filter: filter)
                case "vehicles/":
                    try fetchVehicles(filter: filter)
                case "starships/":
                    try fetchStarships(filter: filter)
                default:
                    fatalError("unsupported data type")
                }
            } catch {
                print(error)
            }
        }
    }
}

