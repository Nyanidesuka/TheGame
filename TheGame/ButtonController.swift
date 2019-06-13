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
     self.layer.cornerRadius = 20
        self.backgroundColor = .blue
    }

}
