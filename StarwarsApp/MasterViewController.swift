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
    static let reuseID = "MasterCell"
    @IBOutlet weak var searchBar: UISearchBar!
    var networkController = NetworkController()
    var detailViewController: DetailTableViewController? = nil
    var dataSource: UITableViewDiffableDataSource<Section, QueryItem>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, QueryItem>! = nil
    var selectedScope: Int = 0
    var items: [QueryItem] = []
    
    enum Section {
        case main
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, QueryItem>()
        dataSource = UITableViewDiffableDataSource<Section, QueryItem>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: Self.reuseID, for: indexPath)
            cell.textLabel?.text = item.description
            return cell
        }
        currentSnapshot.appendSections([.main])
        if let split = splitViewController {
            let controllers = split.viewControllers
            let nav = controllers[controllers.count-1] as! UINavigationController
            detailViewController = nav.topViewController as? DetailTableViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        search(filter: "", page: 1)
    }
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = items[indexPath.row]
                let nav = segue.destination as! UINavigationController
                let controller = nav.topViewController as! DetailTableViewController
                switch object {
                case .person(let model):
                    controller.item = PersonPresenter(model: model)
                case .film(let model):
                    controller.item = FilmPresenter(model: model)
                case .starship(let model):
                    controller.item = StarshipPresenter(model: model)
                case .planet(let model):
                    controller.item = PlanetPresenter(model: model)
                case .vehicle(let model):
                    controller.item = VehiclePresenter(model: model)
                }
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }
    
    func search(filter: String, page: Int) {
        
        func doSearch() {
            do {
                let result = try networkController.search(selectedScope: selectedScope, filter: filter, page: page)
                let (_, items) = result
                let filtered = items.filter {
                    guard filter != "" else { return true }
                    return $0.description.lowercased().contains(filter.lowercased())
                }
                var currentSnapshot = NSDiffableDataSourceSnapshot<Section, QueryItem>()
                currentSnapshot.appendSections([.main])
                currentSnapshot.appendItems(filtered, toSection: .main)
                self.items = filtered
                dataSource.apply(currentSnapshot, animatingDifferences: true)
            } catch {
            }
        }

        DispatchQueue.main.startCoroutine {
            return doSearch()
        }
    }
    
    func reset() {
        currentSnapshot.deleteSections([.main])
        items = []
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
}

extension MasterViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(filter: searchBar.text ?? "", page: 1)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        search(filter: searchBar.text ?? "", page: 1)
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.selectedScope = selectedScope
        reset()
        search(filter: "", page: 1)
    }
}

