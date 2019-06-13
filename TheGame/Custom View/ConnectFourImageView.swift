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
    var pieceColor: Int = 2{
        didSet{
            print("we got set. Value: \(self.pieceColor)")
            if self.pieceColor == 0{
                self.image = UIImage(named: "redPiece")
            } else if self.pieceColor == 1{
                self.image = UIImage(named: "yellowPiece")
            } else {
                self.image = UIImage(named: "grayPiece")
            }
        }
    }
}

//possible piece colors, might just save us some time later.
enum PieceColor: Int{
    case red
    case yellow
}
