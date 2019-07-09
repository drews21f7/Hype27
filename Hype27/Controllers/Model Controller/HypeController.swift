//
//  HypeController.swift
//  Hype27
//
//  Created by Drew Seeholzer on 7/9/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation
import CloudKit

class HypeController {
    
    // MARK: - Hype cannot be controlled
    let publicDB = CKContainer.default().publicCloudDatabase
    // Source of Truth
    var hypes: [Hype] = []
    
    // CRUD
    
    // Save
    
     func saveHype(with text: String, completion: @escaping (Bool) -> Void) {
        let hype = Hype(hypeText: text)
        let hypeRecord = CKRecord(hype: hype)
        publicDB.save(hypeRecord) { (_, error) in
            if let error = error {
                print(" There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
                completion(false)
                return
            }
            self.hypes.append(hype)
            completion(true)
        }
        
    }
    
    // Fetch
    
    func fetchDemHypes(completion: @escaping (Bool) -> Void) {
        
    }
    // Subscription
    
    func subscribeToRemoteNotifications(completion: @escaping (Error?) -> Void) {
        
    }
}
