//
//  VehiclePresenter.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/4/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

struct VehiclePresenter: Decodable, CustomStringConvertible, AttributedConvertable {
    let model: Vehicle
    
    //Note: Expensive to create, create once. 
    public static var dateFormatter: DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.setLocalizedDateFormatFromTemplate("EEEE, MMM dd YYYY")
        return dateFormat
    }
    
    var description: String {
        return model.description
    }
    
    var attributed: NSAttributedString {
        let heading: [NSAttributedString.Key: Any] = [
            .font : UIFont.systemFont(ofSize: 30),
            .foregroundColor: UIColor.red
        ]
        let label: [NSAttributedString.Key: Any] = [
            .font : UIFont.boldSystemFont(ofSize: 17),
            .foregroundColor: UIColor.blue
        ]
        let result = NSMutableAttributedString()
        result.append(NSAttributedString(string: model.name, attributes: heading))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Model: ", attributes: label))
        result.append(NSAttributedString(string: model.model))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Manufacturer: ", attributes: label))
        result.append(NSAttributedString(string: model.manufacturer))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Vehicle Class: ", attributes: label))
        result.append(NSAttributedString(string: model.vehicleClass))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Length: ", attributes: label))
        result.append(NSAttributedString(string: model.length))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Crew: ", attributes: label))
        result.append(NSAttributedString(string: model.crew))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Cost in Credits: ", attributes: label))
        result.append(NSAttributedString(string: model.costInCredits))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Passengers: ", attributes: label))
        result.append(NSAttributedString(string: model.passengers))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Cargo Capacity: ", attributes: label))
        result.append(NSAttributedString(string: model.cargoCapacity))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Created: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: model.created)))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Edited: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: model.edited)))
        return result
    }
}
