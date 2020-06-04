//
//  FilmPresenter.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/4/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

struct FilmPresenter: Decodable, CustomStringConvertible, AttributedConvertable {
    let model: Film

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
        result.append(NSAttributedString(string: model.title, attributes: heading))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Episode: ", attributes: label))
        result.append(NSAttributedString(string: String(model.episodeId)))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: model.openingCrawl))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Director: ", attributes: label))
        result.append(NSAttributedString(string: model.director))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Producer: ", attributes: label))
        result.append(NSAttributedString(string: model.producer))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Release Date: ", attributes: label))
        result.append(NSAttributedString(string: model.releaseDate))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Created: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: model.created)))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Edited: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: model.edited)))
        return result
    }

}
