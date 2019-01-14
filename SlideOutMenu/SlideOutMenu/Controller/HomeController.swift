//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Banerjee,Subhodip on 25/12/18.
//  Copyright © 2018 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {

    let menuController = MenuController()
    fileprivate let menuWidth: CGFloat = 300
    fileprivate var isMenuOpened: Bool = false
    let darkCoverView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleClose))
    }
    
    
    
    @objc func handleOpen(){
        isMenuOpened = true
    }
    
    @objc func handleClose(){
        isMenuOpened = false
    }
    
}

//MARK: TableView DataSource

extension HomeController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "Yo : \(indexPath.row)"
        return cell
    }
}


//MARK: TableView DataSource

extension HomeController: UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
