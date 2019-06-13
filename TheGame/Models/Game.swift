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
    
    var playField: [[Int?]]
    let players: [CKRecord.Reference]
    var turn: Bool
    var isComplete: Bool
    var recordID: CKRecord.ID?
    //be able to make a new Game. Just starting on red turn every time unless specified otherwise later. Every game starts as not complete so setting that as false by default.
    init(players: [CKRecord.Reference], playField: [[Int?]], turn: Bool = true, isComplete: Bool = false){
        self.players = players
        self.playField = playField
        self.turn = turn
        self.isComplete = isComplete
    }
    
    //be able to pull the game from a record
    convenience init?(record: CKRecord){
        guard let players = record[GameKeys.playersKey] as? [CKRecord.Reference],
        let playField = record[GameKeys.playFieldKey] as? [[Int?]],
        let turn = record[GameKeys.turnKey] as? Bool,
            let isComplete = record[GameKeys.isCompleteKey] as? Bool else {print("guarded in the Game convenience init"); return nil}
        self.init(players: players, playField: playField, turn: turn, isComplete: isComplete)
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
}

//extension to make a record from a Game
extension CKRecord{
    convenience init(game: Game){
        let recordID = game.recordID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.init(recordType: GameKeys.typeKey, recordID: recordID)
        setValue(game.players, forKey: GameKeys.playersKey)
        setValue(game.playField, forKey: GameKeys.playFieldKey)
        setValue(game.turn, forKey: GameKeys.turnKey)
        setValue(game.isComplete, forKey: GameKeys.isCompleteKey)
        game.recordID = recordID
    }
}
