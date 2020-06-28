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
            "editedDate": editedDate,
            "characters": characters,
            "vehicles": vehicles,
            "species": species,
            "starships": starships
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
        PresenterAttr.attributed(label: "Episode", value: String(model.episodeID))
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
    
    var planets: [NSAttributedString] {
        [PresenterAttr.attributedHeader(label: "Planets")]
            + model.planets.map { PresenterAttr.attributed(label: $0.description ) }
    }
    
    var characters: [NSAttributedString] {
        [PresenterAttr.attributedHeader(label: "Characters")]
            + model.characters.map { PresenterAttr.attributed(label: $0.description ) }
    }
    
    var vehicles: [NSAttributedString] {
        [PresenterAttr.attributedHeader(label: "Vehicles")]
            + model.vehicles.map { PresenterAttr.attributed(label: $0.description ) }
    }
    
    var species: [NSAttributedString] {
        [PresenterAttr.attributedHeader(label: "Species")]
            + model.species.map { PresenterAttr.attributed(label: $0.description ) }
    }
    
    var starships: [NSAttributedString] {
        [PresenterAttr.attributedHeader(label: "Starships")]
            + model.starships.map { PresenterAttr.attributed(label: $0.description ) }
    }

}
