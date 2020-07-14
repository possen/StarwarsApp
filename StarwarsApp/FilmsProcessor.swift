//
//  FilmsProcessor.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 7/13/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation


struct FilmsProcessor: Processor {
    let networkController: NetworkController
    
    init(networkController: NetworkController) {
        self.networkController = networkController
    }
    
    func process(_ filter: String) throws -> (Int, [QueryItem]) {
        var result = Films(count: 0, next: nil, results: [])
        var page = 1
        repeat {
            let nextResult = try networkController.search(queryType: Films.self, filter: filter, page: page)
            result.results += nextResult.results
            result.count = nextResult.count
            page += 1
        } while result.results.count < result.count
        result.results = result.results.uniqued().sorted { $0.title < $1.title }
        return (result.count, result.results.map { QueryItem.film($0) })
    }
    
}
