//
//  FetchViewControllerViewController.swift
//  TheGame
//
//  Created by Bobba Kadush on 6/13/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class FetchViewControllerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserController.shared.fetchUser { (success) in
            if success{
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "NavController")
                    UIApplication.shared.windows.first?.rootViewController = viewController
                }
                
            }else {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "signUpVC", sender: nil)
                }
            }
        }
    }
}

