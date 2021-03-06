//
//  TableViewCell.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/18/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    var item: Presentable?

    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.textColor = .white
    }
    
    override func prepareForReuse() {
        textLabel?.text = nil
    }
}
