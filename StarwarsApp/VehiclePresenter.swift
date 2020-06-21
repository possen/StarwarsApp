//
//  VehiclePresenter.swift
//  StarwarsApp
//
//

import UIKit

struct VehiclePresenter: CustomStringConvertible, CustomReflectable, Presentable {
    let model: Vehicle
    
    var customMirror: Mirror {
        return Mirror(self, children: [
            "name": name,
            "shipModel": shipModel,
            "manufacturer": manufacturer,
            "vehicleClass": vehicleClass,
            "length": length,
            "crew": crew,
            "costInCredits": costInCredits,
            "passengers": passengers,
            "cargoCapacity": cargoCapacity,
            "createDate": createDate,
            "editedDate": editedDate
        ])
    }
    
    var count: Int {
        customMirror.customMirror.children.count
    }
    
    subscript(index: Int) -> Any {
        let children = customMirror.customMirror.children
        return children[children.index(children.startIndex, offsetBy: index)].value
    }

    var description: String {
        model.description
    }
    
    var name: NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(NSAttributedString(string: model.name, attributes: PresenterAttr.heading))
        return result
    }
    
    var shipModel: NSAttributedString {
        PresenterAttr.attributed(label: "Model", value: model.model)
    }

    var manufacturer: NSAttributedString {
        PresenterAttr.attributed(label: "Manufacturer", value: model.manufacturer)
    }
    
    var vehicleClass: NSAttributedString {
        PresenterAttr.attributed(label: "vehicleClass", value: model.vehicleClass)
    }
    
    var length: NSAttributedString {
        PresenterAttr.attributed(label: "length", value: model.length)
    }
    
    var crew: NSAttributedString {
        PresenterAttr.attributed(label: "Crew", value: model.crew)
    }
    
    var costInCredits: NSAttributedString {
        PresenterAttr.attributed(label: "Cost In Credits", value: model.costInCredits)
    }
    
    var passengers: NSAttributedString {
        PresenterAttr.attributed(label: "Passengers", value: model.passengers)
    }
    
    var cargoCapacity: NSAttributedString {
        PresenterAttr.attributed(label: "Cargo Capacity", value: model.cargoCapacity)
    }

    var createDate: NSAttributedString {
        PresenterAttr.attributed(label: "Release Date", value: PresenterAttr.dateFormatter.string(from: model.created))
    }
    
    var editedDate: NSAttributedString {
        PresenterAttr.attributed(label: "Release Date", value: PresenterAttr.dateFormatter.string(from: model.edited))
    }
}
