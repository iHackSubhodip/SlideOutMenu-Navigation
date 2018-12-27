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
        setupMenuController()
        setupGestureRecognizer()
    }
    

    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleClose))
    }
    
    fileprivate func setupMenuController() {
        menuController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: self.view.frame.height)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(menuController.view)
        addChild(menuController)
    }
    
    fileprivate func performAnimations(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menuController.view.transform = transform
            self.navigationController?.view.transform = transform
        })
    }
    
    fileprivate func setupGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        if gesture.state == .changed{
            var x = translation.x
            x = min(menuWidth, x)
            x = max(0, x)
            let transform = CGAffineTransform(translationX: translation.x, y: 0)
            self.menuController.view.transform = transform
            self.navigationController?.view.transform = transform
        }else{
            handleOpen()
        }
        
    }
    
    @objc func handleOpen(){
        performAnimations(transform: CGAffineTransform(translationX: menuWidth, y: 0))
    }
    
    @objc func handleClose(){
        performAnimations(transform: .identity)
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
