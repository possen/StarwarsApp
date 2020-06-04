//
//  Film.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/3/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation
import UIKit

struct Films: Decodable {
    let count: Int
    let next: URL?
    let results: [Film]
}

struct Film: Decodable, CustomStringConvertible, AttributedConvertable {

    public static var dateFormatter: DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.setLocalizedDateFormatFromTemplate("EEEE, MMM dd")
        return dateFormat
    }

    var description: String {
        return title
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
        result.append(NSAttributedString(string: title, attributes: heading))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Episode: ", attributes: label))
        result.append(NSAttributedString(string: String(episodeId)))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: openingCrawl))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Director: ", attributes: label))
        result.append(NSAttributedString(string: director))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Producer: ", attributes: label))
        result.append(NSAttributedString(string: producer))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Release Date: ", attributes: label))
        result.append(NSAttributedString(string: releaseDate))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Created: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: created)))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Edited: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: edited)))

        return result
    }

    let title: String
    let episodeId: Int
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let species: [URL]
    let starships: [URL]
    let vehicles: [URL]
    let characters: [URL]
    let planets: [URL]
    let created: Date
    let edited: Date
    let url: URL
}
