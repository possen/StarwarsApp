//
//  PlanetPresenter.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/4/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

struct PlanetPresenter: Decodable, CustomStringConvertible, AttributedConvertable {
    let model: Planet
    
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
        result.append(NSAttributedString(string: "Rotation Period: ", attributes: label))
        result.append(NSAttributedString(string: model.rotationPeriod))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Orbital Period: ", attributes: label))
        result.append(NSAttributedString(string: model.orbitalPeriod))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Diameter: ", attributes: label))
        result.append(NSAttributedString(string: model.diameter))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Climate: ", attributes: label))
        result.append(NSAttributedString(string: model.climate))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Gravity: ", attributes: label))
        result.append(NSAttributedString(string: model.gravity))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Terrain: ", attributes: label))
        result.append(NSAttributedString(string: model.terrain))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Surface Water: ", attributes: label))
        result.append(NSAttributedString(string: model.surfaceWater))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Population: ", attributes: label))
        result.append(NSAttributedString(string: model.population))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Created: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: model.created)))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Edited: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: model.edited)))
        return result
    }
}
