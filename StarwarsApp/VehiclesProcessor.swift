//
//  VehiclesProcessor.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 7/13/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation


struct VehicleProcesor: Processor {
    let networkController: NetworkController
    
    init(networkController: NetworkController) {
        self.networkController = networkController
    }
    
    func process(_ filter: String) throws -> (Int, [QueryItem]) {
        var result = Vehicles(count: 0, next: nil, results: [])
        var page = 1
        repeat {
            let nextResult = try networkController.search(queryType: Vehicles.self, filter: filter, page: page)
            result.results += nextResult.results
            result.count = nextResult.count
            page += 1
        } while result.results.count < result.count
        result.results = result.results.uniqued().sorted { $0.name < $1.name }
        return (result.count, result.results.map { QueryItem.vehicle($0) })
    }
}
