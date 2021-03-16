//
//  CustomButton.swift
//  MyntraAssignment
//
//  Created by PRINCE VERMA on 16/03/21.
//

import Foundation
import UIKit
class RightAlignedIconButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let image = UIImage(named:"DropDown")
        self.setTitleColor(.black, for: .normal)
        self.setImage(image, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 24)
        self.backgroundColor = .white
        self.titleLabel?.numberOfLines = 0
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        self.imageEdgeInsets = UIEdgeInsets(top:0, left:self.frame.width - 60, bottom:0, right:0)
        self.contentHorizontalAlignment = .left
    }
}
