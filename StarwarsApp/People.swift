//
//  People.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/3/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation
import UIKit

struct People: Decodable {
    let count: Int
    let next: URL?
    let results: [Person]
}

struct Person: Decodable, CustomStringConvertible, AttributedConvertable {
 
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
        result.append(NSAttributedString(string: "Birth Year: ", attributes: label))
        result.append(NSAttributedString(string: birthYear))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Eye Color: ", attributes: label))
        result.append(NSAttributedString(string: eyeColor))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Height: ", attributes: label))
        result.append(NSAttributedString(string: height))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Mass: ", attributes: label))
        result.append(NSAttributedString(string: mass))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Skin Color: ", attributes: label))
        result.append(NSAttributedString(string: skinColor))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Created: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: created)))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Edited: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: edited)))
        result.append(NSAttributedString(string: "\n"))
        let link:  [NSAttributedString.Key: Any] = [
            .link: url
        ]
        result.append(NSAttributedString(string:"URL", attributes: link))
        return result
    }
    
    let name: String
    let birthYear: String
    let eyeColor: String
    let height: String
    let mass: String
    let skinColor: String
    let homeworld: URL
    let films: [URL]
    let species: [URL]
    let starships: [URL]
    let vehicles: [URL]
    let created: Date
    let edited: Date
    let url: URL
}
