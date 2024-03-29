//
//  UserTableViewController.swift
//  TheGame
//
//  Created by Bobba Kadush on 6/13/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserController.shared.fetchAllUsers { (success) in
            if success{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.shared.allUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        
        let user = UserController.shared.allUsers[indexPath.row]
        cell.textLabel?.text = user.username
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentInviteAlert(title: "It's a Dual", message: "Would you like to challenge \(UserController.shared.allUsers[indexPath.row].username)" )
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGamePlay" {
            print("prepare for segue fired")
            guard let destinVC = segue.destination as? ViewController else {return}
            guard let index = tableView.indexPathForSelectedRow else {return}
            let opponent = UserController.shared.allUsers[index.row]
            GameController.shared.createGame(opponent: opponent) { (game) in
                destinVC.activeGame = game
            }
        }
     }
    
    
    func presentInviteAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "I'm too scared", style: .cancel, handler: nil)
        let challengeAction = UIAlertAction(title: "Challenge", style: .default) { (_) in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toGamePlay", sender: nil)
                
            }
        }
        alertController.addAction(dismissAction)
        alertController.addAction(challengeAction)
        self.present(alertController, animated: true)
    }
    
}

