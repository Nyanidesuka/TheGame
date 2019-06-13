//
//  User.swift
//  TheGame
//
//  Created by Haley Jones on 6/13/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import CloudKit

class User{
    let username: String
    let appleUserReference: CKRecord.Reference
    var recordID: CKRecord.ID?
    
    //be able to make a User
    init(username: String, appleUserReference: CKRecord.Reference){
        self.username = username
        self.appleUserReference = appleUserReference
    }
    //be able to create a User from a CKRecord
    init?(record: CKRecord){
        guard let username = record[UserKeys.usernameKey] as? String,
            let userReference = record[UserKeys.appleUserReferenceKey] as? CKRecord.Reference else {return nil}
        self.username = username
        self.appleUserReference = userReference
        self.recordID = record.recordID
    }
    
}

struct UserKeys{
    static let usernameKey = "username"
    static let appleUserReferenceKey = "appleUserReference"
    static let recordIDKey = "recordID"
    static let typeKey = "User"
}

//An extension so we can make a CKRecord from a user
extension CKRecord{
    convenience init(user: User){
        let recordID = user.recordID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.init(recordType: UserKeys.typeKey, recordID: recordID)
        self.setValue(user.username, forKey: UserKeys.usernameKey)
        self.setValue(user.appleUserReference, forKey: UserKeys.appleUserReferenceKey)
        user.recordID = recordID
    }
}
