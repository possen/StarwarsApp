//
//  StarwarsAppTests.swift
//  StarwarsAppTests
//
//  Created by Paul Ossenbruggen on 6/2/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import XCTest
@testable import ResonanceKit
@testable import StarwarsApp

class StarwarsAppTests: XCTestCase {
    var jsonMockServer: JSONMockServer!
    var mockSession: JSONSession!

    private var baseURL: URL {
        let testBundle = Bundle(for: type(of: self))
        return testBundle.bundleURL.appendingPathComponent("Mocks")
    }

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

    override func setUp() {
        do {
            jsonMockServer = try JSONMockServer(baseURL: baseURL)
            let jsonMockServerSession = JSONMockServerSession(mockServer: jsonMockServer)
            let mockSession = JSONSession(baseURL: URL(string: "https://mocktest.com")!)
            mockSession.keyDecodingStrategy = .convertFromSnakeCase
            mockSession.dateDecodingStrategy = .custom(Self.specialDateDecoder)
            mockSession.urlSession = jsonMockServerSession
            self.mockSession = mockSession
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPeople() throws {
        let exp = expectation(description: "people")
        let queue = DispatchQueue.global()
        queue.startCoroutine {
            let request = JSONRequest<People, ErrorResponse>(
                method: .get,
                path: "/people",
                session: self.mockSession
            )
            let result = try request.perform().await()
            XCTAssertEqual(result.results.count, 10)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 30)        
    }
    
    func testFilms() throws {
        let exp = expectation(description: "Films")
        let queue = DispatchQueue.global()
        queue.startCoroutine {
            do {
                let request = JSONRequest<Films, ErrorResponse>(
                    method: .get,
                    path: "/films",
                    session: self.mockSession
                )
                let result = try request.perform().await()
                XCTAssertEqual(result.results.count, 6)
                XCTAssertEqual(result.count, 6)
                exp.fulfill()
            } catch  {
                print(error)
            }
        }
        wait(for: [exp], timeout: 30)
    }
    
    func testVehicles() throws {
        let exp = expectation(description: "Vehicles")
        let queue = DispatchQueue.global()
        queue.startCoroutine {
            do {
                let request = JSONRequest<Vehicles, ErrorResponse>(
                    method: .get,
                    path: "/vehicles",
                    session: self.mockSession
                )
                let result = try request.perform().await()
                XCTAssertEqual(result.results.count, 10)
                XCTAssertEqual(result.count, 39)
                exp.fulfill()
            } catch  {
                print(error)
            }
        }
        wait(for: [exp], timeout: 30)
    }
    
    func testPlanets() throws {
        let exp = expectation(description: "Planets")
        let queue = DispatchQueue.global()
        queue.startCoroutine {
            do {
                let request = JSONRequest<Planets, ErrorResponse>(
                    method: .get,
                    path: "/planets",
                    session: self.mockSession
                )
                let result = try request.perform().await()
                XCTAssertEqual(result.results.count, 10)
                XCTAssertEqual(result.count, 60)
                exp.fulfill()
            } catch  {
                print(error)
            }
        }
        wait(for: [exp], timeout: 30)
    }
    
    func testStarships() throws {
        let exp = expectation(description: "Starships")
        let queue = DispatchQueue.global()
        queue.startCoroutine {
            do {
                let request = JSONRequest<Starships, ErrorResponse>(
                    method: .get,
                    path: "/starships",
                    session: self.mockSession
                )
                let result = try request.perform().await()
                XCTAssertEqual(result.results.count, 10)
                XCTAssertEqual(result.count, 36)
                exp.fulfill()
            } catch  {
                print(error)
            }
        }
        wait(for: [exp], timeout: 30)
    }
}
