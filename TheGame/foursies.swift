//
//  foursies.swift
//  TheGame
//
//  Created by Bobba Kadush on 6/13/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class foursies: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.transform = CGAffineTransform(rotationAngle: -0.3)
    }

}
