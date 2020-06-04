//
//  Planets.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/3/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation
import UIKit

struct Planets: Decodable {
    let count: Int
    let next: URL?
    let results: [Planet]
}

struct Planet: Decodable, CustomStringConvertible, AttributedConvertable {

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
        result.append(NSAttributedString(string: "Rotation Period: ", attributes: label))
        result.append(NSAttributedString(string: rotationPeriod))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Orbital Period: ", attributes: label))
        result.append(NSAttributedString(string: orbitalPeriod))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Diameter: ", attributes: label))
        result.append(NSAttributedString(string: diameter))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Climate: ", attributes: label))
        result.append(NSAttributedString(string: climate))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Gravity: ", attributes: label))
        result.append(NSAttributedString(string: gravity))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Terrain: ", attributes: label))
        result.append(NSAttributedString(string: terrain))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Surface Water: ", attributes: label))
        result.append(NSAttributedString(string: surfaceWater))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Population: ", attributes: label))
        result.append(NSAttributedString(string: population))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Created: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: created)))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Edited: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: edited)))
        return result
    }

    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [URL]
    let films: [URL]
    let created: Date
    let edited: Date
    let url: URL
}
