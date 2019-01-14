//
//  MenuController.swift
//  SlideOutMenu
//
//  Created by Banerjee,Subhodip on 27/12/18.
//  Copyright © 2018 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {

    let menuItems = [
        SidebarMenuItem(menuImageIcon: #imageLiteral(resourceName: "profile"), menuTitle: "Profile"),
        SidebarMenuItem(menuImageIcon: #imageLiteral(resourceName: "lists"), menuTitle: "Lists"),
        SidebarMenuItem(menuImageIcon: #imageLiteral(resourceName: "bookmarks"), menuTitle: "Bookmarks"),
        SidebarMenuItem(menuImageIcon: #imageLiteral(resourceName: "moments"), menuTitle: "Moments")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }

}

//MARK: TableView DataSource

extension MenuController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomMenuViewCell(style: .default, reuseIdentifier: "cellId")
        let menuItem = menuItems[indexPath.row]
        cell.menuContent.text = menuItem.menuTitle
        cell.menuImageView.image = menuItem.menuImageIcon
        return cell
    }
}


//MARK: TableView Delegate

extension MenuController{
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomMenuHeader()
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let slidingController = UIApplication.shared.keyWindow?.rootViewController as? BaseViewController
        slidingController?.didSelectMenuItem(indexPath)
    }
}


