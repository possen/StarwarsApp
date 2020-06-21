//
//  PresenterTableViewController.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/20/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit


//class PresenterTableViewController: UITableViewController {
//    var pagedPresentables: PagedCollection<Presentable?>!
//    var tableViewAdaptor: TableViewAdaptor!
//    var sectionMain: TableViewAdaptorSection<DetailTableViewCell, PagedCollection<Presentable?>>!
//
//    lazy var adaptor: TableViewAdaptor = {
//        TableViewAdaptor(tableView: tableView, sections: [sectionMain]) { }
//    }()
//
//    func reload() {
//        DispatchQueue.global(qos: .userInitiated).async {}
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        pagedPresentables = PagedCollection<Presentable?>(pageSize: 12, maxEntries: 1000)
//        sectionMain = TableViewAdaptorSection<DetailTableViewCell, PagedCollection>(
//            cellReuseIdentifier: "Cell",
//            title: "",
//            cellHeight: 65,
//            noDataLabel: "No data.",
//            model: pagedPresentables
//        ) { cell, model, index in
//            guard let model = model else {
//                cell.viewData = nil
//                return
//            }
//            cell.viewData = DetailTableViewCell.ViewData(index: index, model: model)
//        }
//        tableViewAdaptor = TableViewAdaptor(tableView: tableView, sections: [sectionMain]) {}
//        pagedPresentables.loadPage = { pageIndex in
//            self.pageLoad(pageIndex: pageIndex, firstLoad: false)
//        }
//        pageLoad(pageIndex: 0, firstLoad: true)
//    }
//
//    func pageLoad(pageIndex: Int, firstLoad: Bool) {
//
//        func load(pageIndex: Int) {
//            do {
//                let model = NetworkController()
//                let pageSize = pagedPresentables.pageSize
//                model.search(query: query, filter: "") {
//                    { results in
//                        // presentation object wrap model objects,
//                        // to keep a clear separation of model and presentation code and associated dependencies.
//                        self.objects = results.map {
//                            switch $0 {
//                            case let model as Person:
//                                return PersonPresenter(model: model)
//                            case let model as Film:
//                                return FilmPresenter(model: model)
//                            case let model as Starship:
//                                return StarshipPresenter(model: model)
//                            case let model as Planet:
//                                return PlanetPresenter(model: model)
//                            case let model as Vehicle:
//                                return VehiclePresenter(model: model)
//                            default:
//                                fatalError("unsupported data")
//                            }
//                        }
//                    }
//                }
//                let result = try model.loadPastTrips(
//                    pageIndex: pageIndex + 1,
//                    pageSize: pagedPresentables.pageSize,
//                )
//                if firstLoad {
//                    pagedPresentables.setInitElements(itemList: [Presentable?](repeating: nil, count: result.count))
//                }
//                let converted = result.results.compactMap { Presentable?($0) }
//                DispatchQueue.main.async { [weak self] in
//                    self?.pagedPastTrips.replace(pageIndexAt: pageIndex, itemList: converted)
//                    self?.adaptor.loading = false
//                    self?.tableView.reloadData()
//                }
//            } catch {
//                DispatchQueue.main.async { [weak self] in
//                    self?.adaptor.loading = false
//                    self?.adaptor.errorStr = error.localizedDescription
//                    self?.tableView.reloadData()
//                }
//            }
//        }
//
//        adaptor.loading = true
//        DispatchQueue.global(qos: .userInitiated).async {
//            load(pageIndex: pageIndex)
//        }
//    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        let cell = sender as! PastTripCell
//        return cell.viewData?.model != nil
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let identifier = segue.identifier,
//            let destVC = segue.destination as? TripsMapViewController else {
//                return
//        }
//        switch identifier {
//        case "Past":
//            let cell = sender as! PastTripCell
//            let mapModel = destVC.mapViewModel.mapModel
//            guard let model = cell.viewData?.model else {
//                return
//            }
//            mapModel.startLocation = model.startLocation
//            mapModel.endLocation = model.endLocation
//            mapModel.startName = model.startLocation.name
//            mapModel.endName = model.endLocation.name
//            destVC.timeFrameKind = .past
//            destVC.timeFrameData = .past(trip: model)
//            destVC.title = dateFormatter.string(from: model.createdAt)
//            destVC.sessionInfo = sessionInfo
//        default:
//            fatalError()
//        }
//    }
//}

