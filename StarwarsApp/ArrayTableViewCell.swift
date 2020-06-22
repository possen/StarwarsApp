//
//  ArrayTableViewCell.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/22/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class ArrayTableViewCell: UITableViewCell {
    var item: [NSAttributedString] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.textColor = .white
    }
    
    override func prepareForReuse() {
        textLabel?.text = nil
    }
}
