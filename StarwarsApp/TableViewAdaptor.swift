//
//  TableViewAdaptor.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/20/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//
import UIKit

protocol TableSectionAdaptor {
    var cellReuseIdentifier: String { get }
    var title: String { get }
    var cellHeight: CGFloat { get }
    var itemCount: Int { get }
    var noDataLabel: String { get }
    func configureSection()
    func configure(cell: UITableViewCell, index: Int)
    func select(index: Int)
}

class TableViewAdaptorSection<Cell, Model: PagedContainer>: TableSectionAdaptor {
    internal let cellReuseIdentifier: String
    internal let title: String
    internal let cellHeight: CGFloat
    internal let noDataLabel: String
    internal let model: Model

    init(
        cellReuseIdentifier: String,
         title: String,
         cellHeight: CGFloat,
         noDataLabel: String,
         model: Model,
         configure: @escaping ( Cell, Model.Item, Int ) -> Void
    ) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.title = title
        self.cellHeight = cellHeight
        self.noDataLabel = noDataLabel
        self.model = model
        self.configure = configure
    }

    internal var itemCount: Int {
        return model.count
    }

    internal func configureSection() {
        model.page(index: 0)
    }

    internal func configure(cell: UITableViewCell, index: Int) {
        model.page(index: index)
        configure(cell as! Cell, model[index], index)
    }

    internal var configure: ( Cell, Model.Item, Int ) -> Void
    
    internal func select(index: Int) {
        guard let select = select else {
            return
        }
        select(model[index], index)
    }

    internal var select: (( Model.Item, Int ) -> Void)?
}

class TableViewAdaptor: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let tableView: UITableView
    private let didChangeHandler: () -> Void
    internal let headerHeight: CGFloat
    private let sections: [TableSectionAdaptor]
    internal var loading = true
    internal var errorStr = ""

    init(
        tableView: UITableView,
         headerHeight: CGFloat = 0,
         sections: [TableSectionAdaptor],
         didChangeHandler: @escaping () -> Void) {
        self.tableView = tableView
        self.didChangeHandler = didChangeHandler
        self.sections = sections
        self.headerHeight = headerHeight
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        func displayNoData(haveData: Bool, section: TableSectionAdaptor) -> Int {
            if haveData {
                tableView.backgroundView = nil
                tableView.separatorStyle = .singleLine
                return 1
            } else if !loading {
                let size = tableView.bounds.size
                let noDataLabel = UILabel(frame: CGRect(
                    x: 0,
                    y: 0,
                    width: size.width,
                    height: size.height
                ))
                noDataLabel.text = errorStr != "" ? errorStr : section.noDataLabel
                noDataLabel.textColor = UIColor(named: "Label")
                noDataLabel.textAlignment = .center
                tableView.separatorStyle = .none
                tableView.backgroundView = noDataLabel
                return 0
            } else {
                let spinner = UIActivityIndicatorView()
                tableView.backgroundView = spinner
                tableView.separatorStyle = .none
                spinner.startAnimating()
                return 0
            }
        }
        let section = sections[section]
        _ = displayNoData(haveData: section.itemCount != 0, section: section)
        return section.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: section.cellReuseIdentifier, for: indexPath)
        section.configure(cell: cell, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        section.select(index: indexPath.row)
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        }
    }
    
    func update() {
        DispatchQueue.main.async {
            self.didChangeHandler()
        }
    }
}
