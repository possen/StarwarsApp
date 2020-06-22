//
//  TableViewController.swift
//  StarwarsApp
//
//  Created by Paul Ossenbruggen on 6/18/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    var item: Presentable? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(image: UIImage(named: "Starwars")!)
        imageView.contentMode = .scaleAspectFill
        tableView.backgroundView = imageView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ArrayTableViewController,
            let cell = sender as? ArrayTableViewCell {
            dest.items = cell.item
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let item = item {
            return item.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let value = item?[indexPath.row] {
            if let array = value as? [NSAttributedString] {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ArrayCell", for: indexPath) as! ArrayTableViewCell
                cell.textLabel?.attributedText = array.first
                cell.item = array
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                cell.textLabel?.attributedText = value as? NSAttributedString
                return cell
            }
        }
        return UITableViewCell()
    }
}
