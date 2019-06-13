//
//  SignUpViewController.swift
//  TheGame
//
//  Created by Bobba Kadush on 6/13/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var gamerTag: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let gamerTag = gamerTag.text else {return}
        UserController.shared.createUser(username: gamerTag) { (success) in
            if success {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "NavController")
                    UIApplication.shared.windows.first?.rootViewController = viewController
                }} else {
                self.presenetSimpleInputAlert(title: "User already Exist", message: "Sorry")
            }
        }
    }
    
    func presenetSimpleInputAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true)
    }
}
