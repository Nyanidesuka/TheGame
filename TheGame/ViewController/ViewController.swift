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
    
    //whats the active game?
    var activeGame: Game?{
        didSet{
            loadViewIfNeeded()
            guard let game = activeGame else {print("no active game"); return}
            GameController.shared.convertIntsToPlayfield(fromArray: game.playField, toPlayfield: self.playField)
        }
    }
    
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
            playField[column][spotIndex].pieceColor = playerTurn ? 0 : 1
            playerTurn = !playerTurn
        }
        let convertedPlayfield = GameController.shared.convertGamePlayfieldToInt(playField: playField)
        print(convertedPlayfield)
        print("trying to update game")
        GameController.shared.updateGame(game: activeGame!, playfield: convertedPlayfield, turn: playerTurn, isComplete: activeGame?.isComplete ?? false) { (success) in
            print("in completion")
            if (success){
                print("success")
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @IBAction func dropButtonPressed(_ sender: UIButton) {
        dropPiece(intoColumn: sender.tag - 1)
    }
    @IBAction func goBackButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toGameTab", sender: nil)
        
    }
}
