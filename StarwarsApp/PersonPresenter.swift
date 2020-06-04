//
//  PersonPresenter.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/4/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

struct PersonPresenter: CustomStringConvertible, AttributedConvertable {
    let model: Person
    
    var description: String {
        return model.description
    }
    
    public static var dateFormatter: DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.setLocalizedDateFormatFromTemplate("EEEE, MMM dd YYYY")
        return dateFormat
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
        result.append(NSAttributedString(string: "Birth Year: ", attributes: label))
        result.append(NSAttributedString(string: model.birthYear))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Eye Color: ", attributes: label))
        result.append(NSAttributedString(string: model.eyeColor))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Height: ", attributes: label))
        result.append(NSAttributedString(string: model.height))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Mass: ", attributes: label))
        result.append(NSAttributedString(string: model.mass))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Skin Color: ", attributes: label))
        result.append(NSAttributedString(string: model.skinColor))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Created: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: model.created)))
        result.append(NSAttributedString(string: "\n"))
        result.append(NSAttributedString(string: "Edited: ", attributes: label))
        result.append(NSAttributedString(string: Self.dateFormatter.string(from: model.edited)))
        result.append(NSAttributedString(string: "\n"))
        let link: [NSAttributedString.Key: Any] = [
            .link: model.url
        ]
        result.append(NSAttributedString(string:"URL", attributes: link))
        return result
    }

}

