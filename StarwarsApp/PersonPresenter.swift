//
//  PeoplePresenter.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/18/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

struct PersonPresenter: CustomStringConvertible, CustomReflectable, Presentable {
    let model: Person

    var customMirror: Mirror {
        return Mirror(self, children: [
            "name": name,
            "birthYear": birthYear,
            "eyeColor": eyeColor,
            "height": height,
            "mass": mass,
            "skinColor": skinColor,
            "created": created,
            "edited": edited,
            "films": films,
            "link": link
        ])
    }
    
    var description: String {
        model.description
    }

    var count: Int {
        customMirror.children.count
    }
    
    subscript(index: Int) -> Any {
        let children = customMirror.children
        return children[children.index(children.startIndex, offsetBy: index)].value
    }
    
    var name: NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(NSAttributedString(string: model.name, attributes: PresenterAttr.heading))
        return result
    }
    
    var birthYear: NSAttributedString {
        PresenterAttr.attributed(label: "Birth Year", value: model.birthYear)
    }
    
    var eyeColor: NSAttributedString {
        PresenterAttr.attributed(label: "Eye Color", value: model.eyeColor)
    }
    
    var height: NSAttributedString {
        PresenterAttr.attributed(label: "Height", value: model.height)
    }
    
    var mass: NSAttributedString {
        PresenterAttr.attributed(label: "Mass", value: model.mass)
    }

    var skinColor: NSAttributedString {
        PresenterAttr.attributed(label: "Skin Color", value: model.skinColor)
    }

    var created: NSAttributedString {
        PresenterAttr.attributed(label: "Created", value: PresenterAttr.dateFormatter.string(from: model.created))
    }
    
    var edited: NSAttributedString {
        PresenterAttr.attributed(label: "Edited", value: PresenterAttr.dateFormatter.string(from: model.edited))
    }
    
    var films: NSAttributedString {
        PresenterAttr.attributed(label: "Films")
    }
    
    var link: NSAttributedString {
        PresenterAttr.attributed(label: "Link", value: model.url.path)
    }
}

