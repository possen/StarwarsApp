//
//  ArrayTableViewController.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/22/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class ArrayTableViewController: UITableViewController {
    var items: [NSAttributedString] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(image: UIImage(named: "Starwars")!)
        imageView.contentMode = .scaleAspectFill
        tableView.backgroundView = imageView
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let value = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "URLCell", for: indexPath)
        cell.textLabel?.attributedText = value
        return cell
    }
}

