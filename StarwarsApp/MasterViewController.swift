//
//  MasterViewController.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/2/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    var detailViewController: DetailViewController? = nil
    let masterDataSource = MasterDataSource()
    let sections = [
        "people/",
        "planets/",
        "films/",
        "vehicles/",
        "starships/"
    ]
    var currentQuery = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuery = sections[0]
        tableView.delegate = masterDataSource
        tableView.dataSource = masterDataSource
        searchBar.delegate = self
        if let split = splitViewController {
            let controllers = split.viewControllers
            let nav = controllers[controllers.count-1] as! UINavigationController
            detailViewController = nav.topViewController as? DetailViewController
        }
        masterDataSource.search(tableView: tableView, query: sections[0], filter: "")
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = masterDataSource.object(tableView: tableView, at: indexPath)
                let nav = segue.destination as! UINavigationController
                let controller = nav.topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }
}

extension MasterViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        masterDataSource.search(tableView: tableView, query: currentQuery, filter: searchText)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        masterDataSource.search(tableView: tableView, query: currentQuery, filter: searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let path = sections[selectedScope]
        currentQuery = path
        masterDataSource.search(tableView: tableView, query: path, filter: "")
    }
}

