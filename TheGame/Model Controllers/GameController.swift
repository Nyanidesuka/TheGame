//
//  GameController.swift
//  TheGame
//
//  Created by Haley Jones on 6/13/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import CloudKit

class GameController{
    
    //shared instance
    static let shared = GameController()
    private init(){}//flex init
    //LOCAL source of persistence. This'll populate with Games pulled from icloud.
    var games: [Game] = []
    //shorthand
    let publicDB = UserController.shared.publicDB
    
    //CRUD Functions
    //create a new game
    func createGame(){
        
    }
    //update an existing game, the crux of this whole thing
    func updateGame(){
        
    }
    //save a new game to the icloud
    func saveGame(){
        
    }
    //fetch games.
    func fetchGames(){
        
    }
    
    //we might wanna delete games; i'm not sure.
    
    
}
