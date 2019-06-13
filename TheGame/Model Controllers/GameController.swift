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
    func createGame(opponent: User, completion: @escaping (Game?) -> Void){
        print("create game fired")
        //so the players in this game will be the active player and whoever they're challenging
        guard let playerOneRecordID = UserController.shared.currentUser?.recordID, let playerTwoRecordID = opponent.recordID else {completion(nil); return}
        //we need a reference to each player
        let playerOneReference = CKRecord.Reference(recordID: playerOneRecordID, action: .deleteSelf)
        let playerTwoReference = CKRecord.Reference(recordID: playerTwoRecordID, action: .deleteSelf)
        
        //we also need to build a blank playfield!
        var playField: [[Int]]{
            var returnArray: [[Int]] = []
            for _ in 0...6{
                var columnArray: [Int] = []
                for _ in 0...5{
                    columnArray.append(2)
                }
                returnArray.append(columnArray)
            }
            print(returnArray)
            return returnArray
        }
        //now we have everything we need for the new game, so lets make it.
        let newGame = Game(players: [playerOneReference, playerTwoReference], playField: playField)
        //Then make it into a record
        let newGameRecord = CKRecord(game: newGame)
        publicDB.save(newGameRecord) { (record, error) in
            if let error = error{
                print("there was an error in \(#function); \(error.localizedDescription)")
                completion(nil);
                return
            }
            guard let record = record, let game = Game(record: record) else {completion(nil); return}
            GameController.shared.games.append(game)
            completion(game)
        }
        
    }
    //update an existing game, the crux of this whole thing
    func updateGame(game: Game, playfield: [[Int?]], turn: Bool, isComplete: Bool, completion: @escaping (Bool) -> Void){
        game.playField = playfield
        game.columnOne = playfield[0]
        game.columnTwo = playfield[1]
        game.columnThree = playfield[2]
        game.columnFour = playfield[3]
        game.columnFive = playfield[4]
        game.columnSix = playfield[5]
        game.columnSeven = playfield[6]
        game.turn = turn
        game.isComplete = isComplete
        let gameRecord = CKRecord(game: game)
        let operation = CKModifyRecordsOperation(recordsToSave: [gameRecord], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        operation.completionBlock = {
            completion(true)
        }
        publicDB.add(operation)
    }
    //save a new game to the icloud
    func saveGame(){
        
    }
    //fetch games.
    func fetchGames(forUser user: User, completion: @escaping (Bool) -> Void){
        let userReference = CKRecord.Reference(record: CKRecord(user: user), action: .deleteSelf)
        let predicate = NSPredicate(format: "playerOne == %@", userReference)
        let query = CKQuery(recordType: GameKeys.typeKey, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error{
                print("there was an error in \(#function); \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let records = records else {completion(false); return}
            //make the records into games
            let convertedGames = records.compactMap({return Game(record: $0)})
            GameController.shared.games += convertedGames
            completion(true)
        }
        let predicateTwo = NSPredicate(format: "playerTwo == %@", userReference)
        let queryTwo = CKQuery(recordType: GameKeys.typeKey, predicate: predicateTwo)
        publicDB.perform(queryTwo, inZoneWith: nil) { (records, error) in
            if let error = error{
                print("there was an error in \(#function); \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let records = records else {completion(false); return}
            //make the records into games
            let convertedGames = records.compactMap({return Game(record: $0)})
            GameController.shared.games += convertedGames
            completion(true)
        }
    }
    
    func convertGamePlayfieldToInt(playField: [[ConnectFourImageView]]) -> [[Int?]]{
        //so this needs to take in the playfield from the connect four vc and then turn it into [[Int?]]
        var returnArray: [[Int?]] = []
        for i in 0...6{
            var column: [Int?] = []
            for j in 0...5{
            let pieceColor = playField[i][j].pieceColor
                column.append(pieceColor)
                
            }
            returnArray.append(column)
        }
        return returnArray
    }
    
    func convertIntsToPlayfield(fromArray array: [[Int?]], toPlayfield playField: [[ConnectFourImageView]]){
        for i in 0...6{
            for j in 0...5{
                if let color = array[i][j]{
                    playField[i][j].pieceColor = color
                }
            }
        }
        print(playField)
    }
    
    func fetchAllGames(completion: @escaping (Bool) -> Void){
       
        //we need to grab all the users of an app and throw them into an array
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: GameKeys.typeKey, predicate: predicate)
        self.publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error{
                print("there was an error in \(#function); \(error.localizedDescription)")
                completion(false)
                return
            }
            //unwrap the records
            guard let records = records else {completion(false); return}
            let games = records.compactMap({return Game(record: $0)})
            GameController.shared.games = games
            completion(true)
        }
        
    }
    
    func fetchPlayersForGame(game: Game, completion: @escaping (Bool) -> Void){
        
    }
    
    
}
