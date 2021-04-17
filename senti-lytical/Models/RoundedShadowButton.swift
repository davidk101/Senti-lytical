//
//  RoundedShadowButton.swift
//  senti-lytical
//
//  Created by David Kumar on 4/17/21.
//  Copyright © 2021 David Kumar. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {
    
    var originalSize : CGRect?
    
    func setupView(){
        
        originalSize = self.frame
        self.layer.cornerRadius = 10.0
        self.layer.shadowRadius = 10.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero // shadow wont move
    }
    
    override func awakeFromNib() {
        setupView()
    }
}
