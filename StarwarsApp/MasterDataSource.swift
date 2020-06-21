//
//  MasterDataSource.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/2/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class MasterDataSource {
    let networkController = NetworkController()
    var pagedPresentables: PagedCollection<Presentable?>!
    var tableViewAdaptor: TableViewAdaptor!
    var sectionMain: TableViewAdaptorSection<MasterTableViewCell, PagedCollection<Presentable?>>!
    let tableView: UITableView
    
    struct PresentableResult {
        let totalCount: Int
        let results: [Presentable]
    }
    
    lazy var adaptor: TableViewAdaptor = {
        TableViewAdaptor(tableView: tableView, sections: [sectionMain]) { }
    }()

    init(tableView: UITableView, query: String) {
        self.tableView = tableView
        reset(query: query, filter: "")
    }
    
    func reset(query: String, filter: String) {
        pagedPresentables = PagedCollection<Presentable?>(pageSize: 10, maxEntries: 1000)
        sectionMain = TableViewAdaptorSection<MasterTableViewCell, PagedCollection>(
            cellReuseIdentifier: "MasterCell",
            title: "",
            cellHeight: 65,
            noDataLabel: "No data.",
            model: pagedPresentables
        ) { cell, model, index in
            guard let model = model else {
                cell.viewData = nil
                return
            }
            cell.viewData = MasterTableViewCell.ViewData(index: index, model: model)
        }
        tableViewAdaptor = TableViewAdaptor(tableView: tableView, sections: [sectionMain]) {}
        pagedPresentables.loadPage = { pageIndex in
            self.pageLoad(query: query, filter: "", pageIndex: pageIndex, firstLoad: false)
        }
        pageLoad(query: query, filter: "", pageIndex: 0, firstLoad: true)
    }
    
    func search(query: String, filter: String) {
        reset(query: query, filter: filter)
        tableView.reloadData()
        pageLoad(query: query, filter: filter, pageIndex: 0, firstLoad: true)
    }

    func search(query: String, filter: String, page: Int) throws -> PresentableResult {
        let result = try networkController.search(query: query, filter: filter, page: page)
        // presentation object wrap model objects,
        // to keep a clear separation of model and presentation code and associated dependencies.
        let transformed: [Presentable] = result.results.map {
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
        return PresentableResult(totalCount: result.totalCount, results: transformed)
    }
        
    func pageLoad(query: String, filter: String, pageIndex: Int, firstLoad: Bool) {
        
        func load() {
            do {
                let result = try search(
                    query: query,
                    filter: filter,
                    page: pageIndex + 1
                )
                if firstLoad {
                    pagedPresentables.setInitElements(
                        itemList: [Presentable?](repeating: nil, count: result.totalCount)
                    )
                }
                let converted = result.results.compactMap { Presentable?($0) }
                pagedPresentables.replace(pageIndexAt: pageIndex, itemList: converted)
                tableView.reloadData()
            } catch {
                adaptor.errorStr = error.localizedDescription
            }
            adaptor.loading = false
            tableView.reloadData()
        }
                
        adaptor.loading = true
        DispatchQueue.main.startCoroutine {
            load()
        }
    }
}
