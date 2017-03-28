//
//  CloudKit.swift
//  instagram-clone
//
//  Created by Kent Rogers on 3/27/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

import Foundation
import CloudKit

class CloudKit {
    
    static let shared = CloudKit()
    
    let container = CKContainer.default()
    var privateDatabase : CKDatabase {
        return self.container.privateCloudDatabase
    }
}
