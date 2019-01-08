//
//  SpacerView.swift
//  SlideOutMenu
//
//  Created by Banerjee,Subhodip on 08/01/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class SpacerView: UIView {

    let space: CGFloat
    
    override var intrinsicContentSize: CGSize{
        return .init(width: space, height: space)
    }
    
    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
