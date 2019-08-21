//
//  CommentObj.swift
//  Euro2016
//
//  Created by Ngọc Toán on 2/9/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit
import SwiftyJSON
import FirebaseDatabase

struct CommentObj {
    
   
    var cmContent: String?
    var cmDatePost: String?
    var cmSenderId: String?
    var cmSenderName: String?
   var cmStatus: String?
   
    
    init(dict: DataSnapshot) {
        self.cmContent = dict.childSnapshot(forPath: "content").value as? String
        self.cmDatePost = dict.childSnapshot(forPath: "datepost").value as? String
        self.cmSenderId = dict.childSnapshot(forPath: "userId").value as? String
        self.cmSenderName = dict.childSnapshot(forPath: "userName").value as? String
         self.cmStatus = dict.childSnapshot(forPath: "status").value as? String
    }
}
