//
//  CustomMenuViewCell.swift
//  SlideOutMenu
//
//  Created by Banerjee,Subhodip on 11/01/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class CustomMenuViewCell: UITableViewCell {

    let menuImageView: CustomMenuImageView = {
        let imageView = CustomMenuImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let menuContent: UILabel = {
        let menuContent = UILabel()
        menuContent.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return menuContent
    }()
    
    private lazy var menuStackView: UIStackView = {
        let menuStackView = UIStackView(arrangedSubviews: [
            menuImageView,
            menuContent,
            UIView()
            ])
        menuStackView.spacing = 8
        menuStackView.isLayoutMarginsRelativeArrangement = true
        menuStackView.layoutMargins = .init(top: 8, left: 12, bottom: 8, right: 12)
        menuStackView.translatesAutoresizingMaskIntoConstraints = false
        return menuStackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
        setupStackViewConstraint()
    }
    
    fileprivate func setupStackView() {
        addSubview(menuStackView)
    }
    
    fileprivate func setupStackViewConstraint() {
        menuStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        menuStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        menuStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        menuStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
