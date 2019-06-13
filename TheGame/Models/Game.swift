//
//  Game.swift
//  TheGame
//
//  Created by Haley Jones on 6/13/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import CloudKit

class Game{
    //Mark: Properties
    
    var columnOne: [Int?]
    var columnTwo: [Int?]
    var columnThree: [Int?]
    var columnFour: [Int?]
    var columnFive: [Int?]
    var columnSix: [Int?]
    var columnSeven: [Int?]
    var playField: [[Int?]]
    
    let playerNames: [String]
    let players: [CKRecord.Reference]
    var turn: Bool
    var isComplete: Bool
    var recordID: CKRecord.ID?
    //be able to make a new Game. Just starting on red turn every time unless specified otherwise later. Every game starts as not complete so setting that as false by default.
    init(players: [CKRecord.Reference], playerNames: [String], playField: [[Int?]], turn: Bool = true, isComplete: Bool = false){
        self.players = players
        self.playField = playField
        self.turn = turn
        self.isComplete = isComplete
        self.columnOne = playField[0]
        self.columnTwo = playField[1]
        self.columnThree = playField[2]
        self.columnFour = playField[3]
        self.columnFive = playField[4]
        self.columnSix = playField[5]
        self.columnSeven = playField[6]
        self.playerNames = playerNames
    }
    
    //be able to pull the game from a record
    convenience init?(record: CKRecord){
        guard let players = record[GameKeys.playersKey] as? [CKRecord.Reference],
        let turn = record[GameKeys.turnKey] as? Bool,
            let isComplete = record[GameKeys.isCompleteKey] as? Bool,
        let columnOne = record[GameKeys.columnOneKey] as? [Int?],
        let columnTwo = record[GameKeys.columnTwoKey] as? [Int?],
        let columnThree = record[GameKeys.columnThreeKey] as? [Int?],
        let columnFour = record[GameKeys.columnFourKey] as? [Int?],
        let columnFive = record[GameKeys.columnFiveKey] as? [Int?],
        let columnSix = record[GameKeys.columnSixKey] as? [Int?],
        let columnSeven = record[GameKeys.columnSevenKey] as? [Int?],
        let playerNames = record["playerNames"] as? [String] else {print("guarded in the Game convenience init"); return nil}
        let playField = [columnOne, columnTwo, columnThree, columnFour, columnFive, columnSix, columnSeven]
        self.init(players: players, playerNames: playerNames, playField: playField, turn: turn, isComplete: isComplete)
        self.recordID = record.recordID
    }
    
}
//anti-typo aparatus
struct GameKeys{
    
    static let typeKey = "Game"
    static let playersKey = "players"
    static let playFieldKey = "playField"
    static let turnKey = "turn"
    static let isCompleteKey = "isComplete"
    static let columnOneKey = "columnOne"
    static let columnTwoKey = "columnTwo"
    static let columnThreeKey = "columnThree"
    static let columnFourKey = "columnFour"
    static let columnFiveKey = "columnFive"
    static let columnSixKey = "columnSix"
    static let columnSevenKey = "columnSeven"
}

//extension to make a record from a Game
extension CKRecord{
    convenience init(game: Game){
        let recordID = game.recordID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.init(recordType: GameKeys.typeKey, recordID: recordID)
        setValue(game.players, forKey: GameKeys.playersKey)
        setValue(game.turn, forKey: GameKeys.turnKey)
        setValue(game.isComplete, forKey: GameKeys.isCompleteKey)
        setValue(game.columnOne, forKey: GameKeys.columnOneKey)
        setValue(game.columnTwo, forKey: GameKeys.columnTwoKey)
        setValue(game.columnThree, forKey: GameKeys.columnThreeKey)
        setValue(game.columnFour, forKey: GameKeys.columnFourKey)
        setValue(game.columnFive, forKey: GameKeys.columnFiveKey)
        setValue(game.columnSix, forKey: GameKeys.columnSixKey)
        setValue(game.columnSeven, forKey: GameKeys.columnSevenKey)
        setValue(game.playerNames, forKey: "playerNames")
        game.recordID = recordID
    }
}
