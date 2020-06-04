//
//  Vehicles.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/3/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation
import UIKit

struct Vehicles: Decodable {
    let count: Int
    let next: URL?
    let results: [Vehicle]
}

struct Vehicle: Decodable, CustomStringConvertible, AttributedConvertable {

    public static var dateFormatter: DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.setLocalizedDateFormatFromTemplate("EEEE, MMM dd")
        return dateFormat
    }

    var description: String {
        return name
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
        result.append(NSAttributedString(string: name, attributes: heading))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Model: ", attributes: label))
        result.append(NSAttributedString(string: model))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Manufacturer: ", attributes: label))
        result.append(NSAttributedString(string: manufacturer))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Vehicle Class: ", attributes: label))
        result.append(NSAttributedString(string: vehicleClass))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Length: ", attributes: label))
        result.append(NSAttributedString(string: length))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Crew: ", attributes: label))
        result.append(NSAttributedString(string: crew))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Cost in Credits: ", attributes: label))
        result.append(NSAttributedString(string: costInCredits))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Passengers: ", attributes: label))
        result.append(NSAttributedString(string: passengers))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Cargo Capacity: ", attributes: label))
        result.append(NSAttributedString(string: cargoCapacity))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Created: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: created)))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Edited: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: edited)))
        return result
    }

    let name: String
    let model: String
    let vehicleClass: String
    let manufacturer: String
    let length: String
    let costInCredits: String
    let crew: String
    let passengers: String
    let maxAtmospheringSpeed: String
    let cargoCapacity: String
    let pilots: [URL]
    let films: [URL]
    let created: Date
    let edited: Date
    let url: URL
}
