//
//  StarshipPresenter.swift
//  StarwarsApp
//
//

import UIKit

struct StarshipPresenter: CustomStringConvertible, CustomReflectable, Presentable {
    let model: Starship
    
    var customMirror: Mirror {
        return Mirror(self, children: [
            "name": name,
            "shipModel": shipModel,
            "costInCredits": costInCredits,
            "length": length,
            "crew": crew,
            "cargoCapacity": cargoCapacity,
            "MGLT": MGLT,
            "consumables": consumables,
            "createDate": createDate,
            "editedDate": editedDate,
            "pilots": pilots,
            "films": films,
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

    var name: NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(NSAttributedString(string: model.name, attributes: PresenterAttr.heading))
        return result
    }

    var shipModel: NSAttributedString {
        PresenterAttr.attributed(label: "Model", value: model.model)
    }
    
    var costInCredits: NSAttributedString {
        PresenterAttr.attributed(label: "Cost In Credits", value: model.costInCredits)
    }
    
    var length: NSAttributedString {
        PresenterAttr.attributed(label: "Length", value: model.length)
    }
    
    var crew: NSAttributedString {
        PresenterAttr.attributed(label: "Crew", value: model.crew)
    }
    
    var cargoCapacity: NSAttributedString {
        PresenterAttr.attributed(label: "Cargo Capacity", value: model.cargoCapacity)
    }
    
    var MGLT: NSAttributedString {
        PresenterAttr.attributed(label: "MGLT", value: model.MGLT)
    }

    var consumables: NSAttributedString {
        PresenterAttr.attributed(label: "Consumables", value: model.consumables)
    }
    
    var films: [NSAttributedString] {
        [PresenterAttr.attributedHeader(label: "Films")]
            + model.films.map { PresenterAttr.attributed(label: $0.description ) }
    }
    
    var pilots: [NSAttributedString] {
        [PresenterAttr.attributedHeader(label: "Pilots")]
            + model.pilots.map { PresenterAttr.attributed(label: $0.description ) }
    }

    var createDate: NSAttributedString {
        PresenterAttr.attributed(label: "Release Date", value: PresenterAttr.dateFormatter.string(from: model.created))
    }
    
    var editedDate: NSAttributedString {
        PresenterAttr.attributed(label: "Release Date", value: PresenterAttr.dateFormatter.string(from: model.edited))
    }
}
