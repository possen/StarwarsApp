//
//  PresenterAttributes.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/18/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

protocol PresentItem {
    var children: Bool { get }
}

protocol Presentable: CustomStringConvertible {
    var count: Int { get }
    subscript(index: Int) -> Any { get }
}

struct PresenterAttr {
    
    static let heading: [NSAttributedString.Key: Any] = [
        .font : UIFont.systemFont(ofSize: 30),
        .foregroundColor: UIColor.red
    ]
    
    static let label: [NSAttributedString.Key: Any] = [
        .font : UIFont.boldSystemFont(ofSize: 17),
        .foregroundColor: UIColor.blue
    ]
    
    static var dateFormatter: DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.setLocalizedDateFormatFromTemplate("EEEE, MMM dd YYYY")
        return dateFormat
    }

    static func appendLabelAttribute(attr: NSMutableAttributedString, string: String) -> NSMutableAttributedString {
        attr.append(NSAttributedString(string: string, attributes: Self.label))
        return attr
    }
    
    static func appendValueAttribute(attr: NSMutableAttributedString, string: String) -> NSMutableAttributedString {
        attr.append(NSAttributedString(string: string))
        return attr
    }

    static func attributed(label: String, value: String) -> NSMutableAttributedString {
        var result = NSMutableAttributedString()
        result = Self.appendLabelAttribute(attr: result, string: label)
        result = Self.appendLabelAttribute(attr: result, string: ": ")
        result = Self.appendValueAttribute(attr: result, string: value)
        return result
    }

    static func attributedHeader(label: String) -> NSMutableAttributedString {
        let attr = NSMutableAttributedString()
        attr.append(NSAttributedString(string: label, attributes: Self.heading))
        return attr
    }

    static func attributed(label: String) -> NSMutableAttributedString {
        var result = NSMutableAttributedString()
        result = Self.appendLabelAttribute(attr: result, string: label)
        return result
    }

}
