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
    

    //columns. These should bve arrays full of the references to the imageViews in the coresponding column. Numbered assuming left to right
    var columnOne: [ConnectFourImageView] = []
    var columnTwo: [ConnectFourImageView] = []
    var columnThree: [ConnectFourImageView] = []
    var columnFour: [ConnectFourImageView] = []
    var columnFive: [ConnectFourImageView] = []
    var columnSix: [ConnectFourImageView] = []
    var columnSeven: [ConnectFourImageView] = []
    //this is the play field; an array containing each of the above columns. Having this will make accessing pieces easier. We'll be able to subscript it like a coordinate system.
    //access like: playField[x][y], or playfield[column][row]
    var playField:[[ConnectFourImageView]] {
        return [columnOne,
                columnTwo,
                columnThree,
                columnFour,
                columnFive,
                columnSix,
                columnSeven]
    }
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func oneButtonPressed(_ sender: Any) {
    }
    @IBAction func twoButtonPressed(_ sender: Any) {
    }
    @IBAction func threeButtonPressed(_ sender: Any) {
    }
    @IBAction func fourButtonPressed(_ sender: Any) {
    }
    @IBAction func fiveButtonPressed(_ sender: Any) {
    }
    @IBAction func sixButtonPressed(_ sender: Any) {
    }
    @IBAction func sevenButtonPressed(_ sender: Any) {
    }
    
    
}

