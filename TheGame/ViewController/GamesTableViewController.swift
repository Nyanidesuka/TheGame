//
//  GamesTableViewController.swift
//  TheGame
//
//  Created by Bobba Kadush on 6/13/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit
import CloudKit

class GamesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = UserController.shared.currentUser else {return}
        GameController.shared.fetchAllGames { (success) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameController.shared.games.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)

        let game = GameController.shared.games[indexPath.row]
        print(game.players.count)
        
        let opponentRecord = CKRecord(recordType: UserKeys.typeKey, recordID: game.players[0].recordID)
        
//        guard let opponent = User(record: opponentRecord) else {print("couldn't make a user from the record"); return UITableViewCell()}
        print("gamer")
        cell.textLabel?.text = "\(game.playerNames[0]) vs \(game.playerNames[1])"
        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    */

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGame"{
            guard let destinVC = segue.destination as? ViewController,
            let index = tableView.indexPathForSelectedRow else {return}
            destinVC.activeGame = GameController.shared.games[index.row]
        }
    }
    

}
