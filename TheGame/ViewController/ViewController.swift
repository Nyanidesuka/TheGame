//
//  ViewController.swift
//  TheGame
//
//  Created by Haley Jones on 6/12/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    //Whose turn is it? true = Red, false = Yellow
    var playerTurn: Bool = false
    
    //columns. These are arrays full of the references to the imageViews in the coresponding column. Numbered assuming top to bottom, left to right
    @IBOutlet var columnOneCollection: [ConnectFourImageView]!
    
    @IBOutlet var columnTwoCollection: [ConnectFourImageView]!
    
    @IBOutlet var columnThreeCollection: [ConnectFourImageView]!
    
    @IBOutlet var columnFourCollection: [ConnectFourImageView]!
    
    @IBOutlet var columnFiveCollection: [ConnectFourImageView]!
    
    @IBOutlet var columnSixCollection: [ConnectFourImageView]!
    
    @IBOutlet var columnSevenCollection: [ConnectFourImageView]!
    
    //this is the play field; an array containing each of the above columns. Having this will make accessing pieces easier. We'll be able to subscript it like a coordinate system.
    //access like: playField[x][y], or playfield[column][row]
    var playField:[[ConnectFourImageView]] {
        return [columnOneCollection,
                columnTwoCollection,
                columnThreeCollection,
                columnFourCollection,
                columnFiveCollection,
                columnSixCollection,
                columnSevenCollection]
    }
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //i added all the outlets in the wrong order and reversin them will give us easier columns to work with
        var alpha = CGFloat(1)
        for imageView in columnOneCollection{
            imageView.alpha = alpha
            alpha -= 0.1
        }
        print(GameController.shared.convertGamePlayfieldToInt(playField: playField))
    }
    
    func dropPiece(intoColumn column: Int){
        //first up, find a spot.
        var spotIndex = 5
        for spot in 0...5{
            if playField[column][spot].image != UIImage(named: "grayPiece"){
                //so if we get here we know it's occupied. Because pieceColor starts as nil.
                //if the spot is taken or if we've hit the end of the array, we know we've reached the "bottom"
                spotIndex = max(min(spot - 1, spotIndex), 0)
                print(spotIndex)
            }else if spot == 5 {
                print("in the else if")
                spotIndex = 5
            }
        }
        //actual stick the piece in there.
        if playField[column][spotIndex].image == UIImage(named: "grayPiece"){
            playField[column][spotIndex].pieceColor = playerTurn ? PieceColor.red : PieceColor.yellow
            playerTurn = !playerTurn
        }
    }
    
    @IBAction func dropButtonPressed(_ sender: UIButton) {
        dropPiece(intoColumn: sender.tag - 1)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        for column in playField{
            for spot in column{
                spot.image = UIImage(named: "grayPiece")
                spot.pieceColor = nil
            }
        }
    }
    
}

