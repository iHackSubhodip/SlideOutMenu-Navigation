//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Banerjee,Subhodip on 25/12/18.
//  Copyright © 2018 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    
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
        let vc = MenuController()
        vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: self.view.frame.height)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(vc.view)
    }
    
    @objc func handleClose(){
        print("Close")
    }
    
}

//MARK: TableView DataSource

extension ViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "Yo : \(indexPath.row)"
        return cell
    }
}
