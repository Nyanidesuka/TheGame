//
//  ConnectFourImageView.swift
//  TheGame
//
//  Created by Haley Jones on 6/12/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class ConnectFourImageView: UIImageView {
    //this will be nil if the slot is empty; otherwise it'll tell us what color piece is in that spot.
    var pieceColor: Int??{
        didSet{
            guard let pieceColor = self.pieceColor else {self.image = UIImage(named: "grayPiece"); return}
            self.image = UIImage(named: pieceColor == 0 ? "redPiece" : "yellowPiece")
        }
    }
}

//possible piece colors, might just save us some time later.
enum PieceColor: Int{
    case red
    case yellow
}
