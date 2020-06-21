//
//  PagedCollection.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/20/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation

protocol PagedContainer {
    associatedtype Item
    var count: Int { get }
    func page(index: Int)
    subscript(index: Int) -> Item { get }
    var loadPage: (Int) -> Void { get set }
}

class PagedCollection<Element>: PagedContainer {
    let pageSize: Int
    let maxEntries: Int
    lazy var blockRequested = [Bool](repeating: false, count: (items.count / pageSize) + 1)
    var loadPage: (Int) -> Void = {_ in }
        
    init(pageSize: Int, maxEntries: Int) {
        self.pageSize = pageSize
        self.maxEntries = maxEntries
    }
    
    var items = [Element]()
    
    func setInitElements(itemList: [Element]) {
        items = itemList
    }
    
    func reset() {
        items = []
    }
    
    func append(_ itemList: [Element]) {
        items += itemList
    }
    
    func replace(pageIndexAt pageIndex: Int, itemList: [Element]) {
        let offset = pageIndex * pageSize
        items.replaceSubrange(offset..<(itemList.count + offset), with: itemList)
    }
    
    func page(index: Int) {
        let blockIndex = index / pageSize
        if !blockRequested[blockIndex] {
            loadPage(blockIndex)
            blockRequested[blockIndex] = true
        }
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(index: Int) -> Element {
        return items[index]
    }
}
