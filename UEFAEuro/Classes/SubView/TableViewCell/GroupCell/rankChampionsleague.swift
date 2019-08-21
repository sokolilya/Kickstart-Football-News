//
//  rankChampionsleague.swift
//  WORLDCUP
//
//  Created by HiCom on 8/6/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit
import SwiftyJSON

class rankChampionsleague: NSObject {
    var SttID: String!
    var RankID: String!
    var TeamID: String!
    var PlayedID: String!
    var WinID: String!
    var DrawID: String!
    var LostID: String!
    var GDID: String!
    var PtsID: String!
    var mRound: String!
    var groupName: String!
    var groupID: String!
    var teamSelected: Bool = false
    var groupArrClup: [groupObj]!
    
//    init(dicObj: JSON) {
//    self.SttID = JSON(dicObj)["position"].stringValue
//    self.TeamID = JSON(dicObj)["name"].stringValue
//    self.PlayedID = JSON(dicObj)["played"].stringValue
//    self.WinID = JSON(dicObj)["win"].stringValue
//    self.DrawID = JSON(dicObj)["draw"].stringValue
//    self.LostID = JSON(dicObj)["lose"].stringValue
//    self.GDID = JSON(dicObj)["gDiff"].stringValue
//    self.PtsID = JSON(dicObj)["point"].stringValue
//
//    }

}
