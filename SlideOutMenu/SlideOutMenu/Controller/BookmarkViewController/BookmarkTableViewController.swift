//
//  BookmarkTableViewController.swift
//  SlideOutMenu
//
//  Created by Banerjee,Subhodip on 14/01/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class BookmarkTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

// MARK: - Table view data source
extension BookmarkTableViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Bookmar \(indexPath.row)"
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
