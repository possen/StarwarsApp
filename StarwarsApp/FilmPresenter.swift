//
//  FilmPresenter.swift
//  StarwarsApp
//
//

import UIKit

struct FilmPresenter: CustomStringConvertible, CustomReflectable, Presentable {
    let model: Film
    
    var customMirror: Mirror {
        return Mirror(self, children: [
            "title": title,
            "director": director,
            "producer": producer,
            "openingCrawl": openingCrawl,
            "releaseDate": releaseDate,
            "createDate": createDate,
            "editedDate": editedDate
        ])
    }

    var description: String {
        return model.description
    }
    var count: Int {
        customMirror.children.count
    }
    
    subscript(index: Int) -> Any {
        let children = customMirror.children
        return children[children.index(children.startIndex, offsetBy: index)].value
    }

    var title: NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(NSAttributedString(string: model.title, attributes: PresenterAttr.heading))
        return result
    }
    
    var episodeId: NSAttributedString {
        PresenterAttr.attributed(label: "Episode", value: String(model.episodeId))
    }
    
    var openingCrawl: NSAttributedString {
        PresenterAttr.attributed(label: "Opening", value: model.openingCrawl)
    }
    
    var director: NSAttributedString {
        PresenterAttr.attributed(label: "Director", value: model.director)
    }
    
    var producer: NSAttributedString {
        PresenterAttr.attributed(label: "Producer", value: model.producer)
    }

    var releaseDate: NSAttributedString {
        PresenterAttr.attributed(label: "Release Date", value: model.releaseDate)
    }
    
    var createDate: NSAttributedString {
        PresenterAttr.attributed(label: "Release Date", value: PresenterAttr.dateFormatter.string(from: model.created))
    }
    
    var editedDate: NSAttributedString {
        PresenterAttr.attributed(label: "Release Date", value: PresenterAttr.dateFormatter.string(from: model.edited))
    }
}
