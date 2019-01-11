//
//  CustomMenuHeader.swift
//  SlideOutMenu
//
//  Created by Banerjee,Subhodip on 08/01/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class CustomMenuHeader: UIView {
    
    private lazy var profileImageView: CustomImageView = {
        let profileImageView = CustomImageView()
        profileImageView.image = UIImage(named: "image")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        return profileImageView
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Subhodip Banerjee"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private lazy var userNameLabel: UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.text = "@iHack"
        userNameLabel.font = UIFont.systemFont(ofSize: 12)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return userNameLabel
    }()
    
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Hey, have a Good day..."
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    
    private lazy var menuStackView: UIStackView = {
        let menuStackView = UIStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [profileImageView, UIView()]),
            nameLabel,
            userNameLabel,
            SpacerView(space: 3),
            statusLabel])
        menuStackView.axis = .vertical
        menuStackView.spacing = 8
        menuStackView.isLayoutMarginsRelativeArrangement = true
        menuStackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        menuStackView.translatesAutoresizingMaskIntoConstraints = false
        return menuStackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
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
        fatalError("issue is there")
    }

}
