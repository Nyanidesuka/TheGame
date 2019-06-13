//
//  UserController.swift
//  TheGame
//
//  Created by Haley Jones on 6/13/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import CloudKit

class UserController{
    //shared instance
    static let shared = UserController()
    //keep track of the current user, if there is one.
    var currentUser: User?
    //a reference to the database
    let publicDB = CKContainer.default().publicCloudDatabase
    private init(){} //flex
    
    //an array of ALL users so we can populate the table view later. This'll also need a fetch.
    var allUsers: [User] = []
    
    //CRUD functions
    
    //first up we need to be able to fetch a user if one exists.
    func fetchUser(completion: @escaping (Bool) -> Void){
        //grab the userID for the icloud user running the app
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error{
                print("there was an error in \(#function); \(error.localizedDescription)")
                completion(false)
                return
            }
            //unwrap the recordID we got
            guard let recordID = recordID else {completion(false); return}
            //use that ID to make a reference
            let userReference = CKRecord.Reference(recordID: recordID, action: .deleteSelf)
            //we can now use that reference to make a predicate for a query that will fetch the current user's record.
            let predicate = NSPredicate(format: "%K == %@", UserKeys.appleUserReferenceKey, userReference)
            let query = CKQuery(recordType: UserKeys.typeKey, predicate: predicate)
            self.publicDB.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
                if let error = error{
                    print("there was an error in \(#function); \(error.localizedDescription)")
                    completion(false)
                    return
                }
                //unwrap the array of (hopefully) one record
                guard let records = records , records.count != 0, let userRecord = records.first else {completion(false); return}
                //make a user out of that record
                let fetchedUser = User(record: userRecord)
                //and set them as the current user
                self.currentUser = fetchedUser
                completion(true)
            })
            
        }
    }
    
    //next up if there is no user we gotta create one.
    func createUser(username: String, completion: @escaping (Bool) -> Void){
        //get the icloud user reference
        CKContainer.default().fetchUserRecordID { (userRecordID, error) in
            if let error = error{
                print("there was an error in \(#function); \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let userID = userRecordID else {completion(false); return}
            //now we have an ID and we can use it to make a reference
            let userReference = CKRecord.Reference(recordID: userID, action: .deleteSelf)
            //make a user from the username we passed in and the reference we just made
            let newUser = User(username: username, appleUserReference: userReference)
            //and make that user into a record so we can save it.
            let userRecord = CKRecord(user: newUser)
            self.publicDB.save(userRecord, completionHandler: { (record, error) in
                if let error = error{
                    print("there was an error in \(#function); \(error.localizedDescription)")
                    completion(false)
                    return
                }
                //set that new user as the current user
                self.currentUser = newUser
                completion(true)
            })
        }
    }
    
    func fetchAllUsers(completion: @escaping (Bool) -> Void){
        //we need to grab all the users of an app and throw them into an array
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: UserKeys.typeKey, predicate: predicate)
        self.publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error{
                print("there was an error in \(#function); \(error.localizedDescription)")
                completion(false)
                return
            }
            //unwrap the records
            guard let records = records else {completion(false); return}
            let users = records.compactMap({return User(record: $0)})
            UserController.shared.allUsers = users
            completion(true)
        }
    }
}
