//
//  ListViewController.swift
//  SlideOutMenu
//
//  Created by Banerjee,Subhodip on 14/01/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "List"
        label.textAlignment = .center
        label.frame = view.frame
        
        view.addSubview(label)
    }

}
