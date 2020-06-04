//
//  MasterDataSource.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/2/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class MasterDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var objects = [Any]()
    let networkController = NetworkController()
    
    override init() {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = objects[indexPath.row] as? CustomStringConvertible
        cell.textLabel?.text = object?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
        
    func object(tableView: UITableView, at indexPath: IndexPath) -> Any {
        return objects[indexPath.row]
    }
    
    func search(tableView: UITableView, query: String, filter: String) {
        networkController.search(query: query, filter: filter) { results in
            // presentation object wrap model objects,
            // to keep a clear separation of model and presentation code and associated dependencies.
            self.objects = results.map {
                switch $0 {
                case let model as Person:
                    return PersonPresenter(model: model)
                case let model as Film:
                    return FilmPresenter(model: model)
                case let model as Starship:
                    return StarshipPresenter(model: model)
                case let model as Planet:
                    return PlanetPresenter(model: model)
                case let model as Vehicle:
                    return VehiclePresenter(model: model)
                default:
                    fatalError("unsupported data")
                }
            }
            tableView.reloadData()
        }
    }
}
