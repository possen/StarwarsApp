//
//  MasterViewController.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/2/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit
import SwiftCoroutine

class MasterViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    var detailViewController: DetailTableViewController? = nil
    let searches = [
        "people/",
        "planets/",
        "films/",
        "vehicles/",
        "starships/"
    ]
    var currentQuery = ""
    var masterDataSource: MasterDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuery = searches[0]
        searchBar.delegate = self
        masterDataSource = MasterDataSource(tableView: tableView, query: currentQuery)
        if let split = splitViewController {
            let controllers = split.viewControllers
            let nav = controllers[controllers.count-1] as! UINavigationController
            detailViewController = nav.topViewController as? DetailTableViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
//                let object = masterDataSource.object(tableView: tableView, at: indexPath)
                let nav = segue.destination as! UINavigationController
                let controller = nav.topViewController as! DetailTableViewController
//                controller.item = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }
}

extension MasterViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        masterDataSource?.search( query: currentQuery, filter: searchText)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        masterDataSource?.search(query: currentQuery, filter: searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let path = searches[selectedScope]
        currentQuery = path
        masterDataSource?.search(query: path, filter: "")
    }
}

