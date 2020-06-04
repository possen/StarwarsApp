//
//  Starships.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/3/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation
import UIKit

struct Starships: Decodable {
    let count: Int
    let next: URL?
    let results: [Starship]
}

struct Starship: Decodable, CustomStringConvertible, AttributedConvertable {
    
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
        result.append(NSAttributedString(string: "Cost in Credits: ", attributes: label))
        result.append(NSAttributedString(string: costInCredits))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Length: ", attributes: label))
        result.append(NSAttributedString(string: length))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Crew: ", attributes: label))
        result.append(NSAttributedString(string: crew))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "MGLT: ", attributes: label))
        result.append(NSAttributedString(string: MGLT))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Cargo Capacity: ", attributes: label))
        result.append(NSAttributedString(string: cargoCapacity))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Consumables: ", attributes: label))
        result.append(NSAttributedString(string: consumables))
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
    let manufacturer: String
    let costInCredits: String
    let length: String
    let crew: String
    let passengers: String
    let maxAtmospheringSpeed: String
    let hyperdriveRating: String
    let MGLT: String
    let cargoCapacity: String
    let consumables: String
    let films: [URL]
    let pilots: [URL]
    let created: Date
    let edited: Date
    let url: URL
}
