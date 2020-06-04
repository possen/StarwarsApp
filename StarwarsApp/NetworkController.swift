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
    
    func search(query: String, completion: @escaping ([Any]) -> Void)  {
        DispatchQueue.main.startCoroutine {
            do {
                switch query {
                case "people/":
                    let request = JSONRequest<People, ErrorResponse>(method: .get, path: query, session: self.session)
                    let result = try request.perform().await()
                    completion(result.results)
                case "planets/":
                    let request = JSONRequest<Planets, ErrorResponse>(method: .get, path: query, session: self.session)
                    let result = try request.perform().await()
                    completion(result.results)
                case "films/":
                    let request = JSONRequest<Films, ErrorResponse>(method: .get, path: query, session: self.session)
                    let result = try request.perform().await()
                    completion(result.results)
                case "vehicles/":
                    let request = JSONRequest<Vehicles, ErrorResponse>(method: .get, path: query, session: self.session)
                    let result = try request.perform().await()
                    completion(result.results)
                case "starships/":
                    let request = JSONRequest<Starships, ErrorResponse>(method: .get, path: query, session: self.session)
                    let result = try request.perform().await()
                    completion(result.results)
                default:
                    fatalError("unsupported data type")
                }
            } catch {
                print(error)
            }
        }
    }
}

