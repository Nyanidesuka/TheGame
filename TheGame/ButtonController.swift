//
//  ButtonController.swift
//  TheGame
//
//  Created by Bobba Kadush on 6/13/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class ButtonController: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
     self.layer.cornerRadius = 5
        self.backgroundColor = .green
        self.layer.zPosition = 1
        self.titleLabel?.font = UIFont(name: "Helvetica", size: 24)
    }

}
