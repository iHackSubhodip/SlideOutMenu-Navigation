//
//  BaseViewController.swift
//  SlideOutMenu
//
//  Created by Banerjee,Subhodip on 02/01/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class RightContainerView: UIView {}
class MenuContainerView: UIView {}
class DarkCoverView: UIView {}

class BaseViewController: UIViewController {

    let redView: RightContainerView = {
        let view = RightContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let blueView: MenuContainerView = {
        let view = MenuContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let darkCoverView: DarkCoverView = {
        let v = DarkCoverView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    var redViewLeadingConstraint: NSLayoutConstraint!
    fileprivate let menuWidth: CGFloat = 300
    fileprivate var isMenuOpened = false
    fileprivate let velocityThreshold: CGFloat = 500
    var rightViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupView()
        setupGestureRecognizer()
        setupViewController()
    }
}

//MARK: View Setup
extension BaseViewController{
    
    fileprivate func setupView(){
        view.addSubview(redView)
        view.addSubview(blueView)
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.safeAreaLayoutGuide.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth)
            ])
        redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstraint.isActive = true
    }
    
    fileprivate func setupViewController(){
        rightViewController = HomeController()
        let menuController = MenuController()
        
        guard let rightVC = rightViewController else{
            return
        }
        
        let homeView = rightVC.view!
        let menuView = menuController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(homeView)
        redView.addSubview(darkCoverView)
        blueView.addSubview(menuView)
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: redView.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            
            menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
            menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            
            darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            ])
        
        addChild(rightVC)
        addChild(menuController)
    }
}


//MARK: Gesture Setup
extension BaseViewController{
    
    fileprivate func setupGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpened {
            if abs(velocity.x) > velocityThreshold {
                closeMenu()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if abs(velocity.x) > velocityThreshold {
                openMenu()
                return
            }
            
            if translation.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenuOpened ? x + menuWidth : x
        
        x = min(menuWidth, x)
        x = max(0, x)
        
        redViewLeadingConstraint.constant = x
        darkCoverView.alpha = x / menuWidth
        
        if gesture.state == .ended{
            handleEnded(gesture: gesture)
        }
    }
    
}

//MARK: Menu operation [open/close]
extension BaseViewController{
    
    func openMenu() {
        isMenuOpened = true
        redViewLeadingConstraint.constant = menuWidth
        performAnimations()
    }
    
    func closeMenu() {
        redViewLeadingConstraint.constant = 0
        isMenuOpened = false
        performAnimations()
    }

    
    func didSelectMenuItem(_ indexPath: IndexPath){
        cleanupRightViewController()
        
        switch indexPath.row {
        case 0:
            print("Profile")
        case 1:
            let listController = ListViewController()
            redView.addSubview(listController.view)
            addChild(listController)
            rightViewController = listController
        case 2:
            let bookmarkController = BookmarkTableViewController()
            redView.addSubview(bookmarkController.view)
            addChild(bookmarkController)
            rightViewController = bookmarkController
        default:
            print("manage")
        }
        redView.bringSubviewToFront(darkCoverView)
        closeMenu()
    }
    
    fileprivate func cleanupRightViewController(){
        rightViewController?.view.removeFromSuperview()
        rightViewController?.removeFromParent()
    }
    
    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            // leave a reference link down in desc below
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        })
    }
    
}
