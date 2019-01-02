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
        setupNavigationItems()
        setupMenuController()
        setupGestureRecognizer()
        setupDarkCoverView()
    }
    
    fileprivate func setupDarkCoverView(){
        darkCoverView.alpha = 0.0
        darkCoverView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        darkCoverView.isUserInteractionEnabled = false
        UIApplication.shared.keyWindow?.addSubview(darkCoverView)
        darkCoverView.frame = UIApplication.shared.keyWindow?.frame ?? .zero
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
            self.darkCoverView.transform = transform
            self.darkCoverView.alpha = (transform == .identity) ? 0 : 1
        })
    }
    
    fileprivate func setupGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
    }
    
    fileprivate func handleEndedGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if isMenuOpened{
            if abs(translation.x) < menuWidth / 2{
                handleOpen()
            }else{
                handleClose()
            }
        }else{
            if translation.x < menuWidth / 2{
                handleClose()
            }else{
                handleOpen()
            }
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //fix needed for view transition.
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        if gesture.state == .changed{
            var x = translation.x
            if isMenuOpened{
                x += menuWidth
            }
            x = min(menuWidth, x)
            x = max(0, x)
            let transform = CGAffineTransform(translationX: x, y: 0)
            self.menuController.view.transform = transform
            self.navigationController?.view.transform = transform
            darkCoverView.transform = transform
            darkCoverView.alpha = x / menuWidth
        }else if gesture.state == .ended{
            handleEndedGesture(gesture)
        }
        
    }
    
    @objc func handleOpen(){
        isMenuOpened = true
        performAnimations(transform: CGAffineTransform(translationX: menuWidth, y: 0))
    }
    
    @objc func handleClose(){
        isMenuOpened = false
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


//MARK: TableView DataSource

extension HomeController: UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
