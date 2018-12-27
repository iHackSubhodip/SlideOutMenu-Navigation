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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleClose))
    }

    @objc func handleOpen(){
        menuController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: self.view.frame.height)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(menuController.view)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menuController.view.transform = CGAffineTransform(translationX: self.menuWidth, y: 0)
        })
        addChild(menuController)
    }
    
    @objc func handleClose(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menuController.view.transform = .identity
        })
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
