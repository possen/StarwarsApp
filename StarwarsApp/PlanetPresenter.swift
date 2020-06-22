//
//  PlanetPresenter.swift
//  StarwarsApp
//
//

import UIKit

struct PlanetPresenter: CustomStringConvertible, CustomReflectable, Presentable {    
    let model: Planet
    
    var customMirror: Mirror {
        return Mirror(self, children: [
            "name": name,
            "rotationPeriod": rotationPeriod,
            "orbitalPeriod": orbitalPeriod,
            "diameter": diameter,
            "climate": climate,
            "gravity": gravity,
            "terrain": terrain,
            "surfaceWater": surfaceWater,
            "population": population,
            "createDate": createDate,
            "editedDate": editedDate,

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

    var rotationPeriod: NSAttributedString {
        PresenterAttr.attributed(label: "Rotation Period", value: model.rotationPeriod)
    }
    
    var orbitalPeriod: NSAttributedString {
        PresenterAttr.attributed(label: "Orbital Period", value: model.orbitalPeriod)
    }

    var diameter: NSAttributedString {
        PresenterAttr.attributed(label: "Diameter", value: model.diameter)
    }
    
    var climate: NSAttributedString {
        PresenterAttr.attributed(label: "Climate", value: model.climate)
    }
    
    var gravity: NSAttributedString {
        PresenterAttr.attributed(label: "Gravity", value: model.gravity)
    }
    
    var terrain: NSAttributedString {
        PresenterAttr.attributed(label: "Terrain", value: model.terrain)
    }

    var surfaceWater: NSAttributedString {
        PresenterAttr.attributed(label: "Surface Water", value: model.surfaceWater)
    }
    
    var population: NSAttributedString {
        PresenterAttr.attributed(label: "Population", value: model.population)
    }

    var createDate: NSAttributedString {
        PresenterAttr.attributed(label: "Release Date", value: PresenterAttr.dateFormatter.string(from: model.created))
    }
    
    var editedDate: NSAttributedString {
        PresenterAttr.attributed(label: "Release Date", value: PresenterAttr.dateFormatter.string(from: model.edited))
    }
}
