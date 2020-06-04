//
//  DetailViewController.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/2/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    func configureView() {
        if let detail = detailItem as? AttributedConvertable {
            if let label = detailDescriptionLabel {
                label.attributedText = detail.attributed
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    var detailItem: Any? {
        didSet {
            configureView()
        }
    }
}

