//
//  MasterTableViewCell.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/20/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit


class MasterTableViewCell: UITableViewCell {
    var item: Presentable?
    @IBOutlet weak var activity: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.textColor = .white
    }
    
    override func prepareForReuse() {
        textLabel?.text = nil
    }
    
    internal struct ViewData {
        let index: Int
        let model: Presentable
    }

    var viewData: ViewData? {
        didSet {
            guard let model = viewData?.model else {
                activity.startAnimating()
                activity.style = .medium
                return
            }
            textLabel?.text = model.description
            activity.stopAnimating()
        }
    }
}

