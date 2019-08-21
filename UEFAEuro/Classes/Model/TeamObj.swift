//
//  TeamObj.swift
//  UEFAEuro
//
//  Created by HiCom on 4/8/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit
import SwiftyJSON

class TeamObj: NSObject {
   var teamId: String!
   var leagueId : String!
    var typeId:  String!
    var teamName: String!
    var teamImage: String!
   var teamPlayed: String!
   var teamWin: String!
   var teamDraw: String!
   var teamLose: String!
   var teamMgFor: String!
   var teamMgAgain: String!
   var teamGDiff : String!
   var teamPoint : String!
   var teamPosition : String!
   var teameEtablished : String!
   var teamManager : String!
   var teamNickName : String!
   var teamStadium : String!
   var teameClubUrl : String!
    var SttID: String!
    var RankID: String!
    var TeamID: String!
    var playerID: String!
    var WinID: String!
    var DrawID: String!
    var LoseID: String!
    var PointID: String!
    var GDID: String!
   
   init(dict: JSON) {
      self.typeId = dict["type"].stringValue
      self.teamId = dict["id"].stringValue
      self.teamName = dict["name"].stringValue
      self.teamImage = dict["image"].stringValue
      self.teamPlayed = dict["played"].stringValue
      self.teamWin = dict["win"].stringValue
      self.teamDraw = dict["draw"].stringValue
      self.teamMgFor = dict["mgFor"].stringValue
      self.teamMgAgain = dict["mgAgainst"].stringValue
      self.teamGDiff = dict["gDiff"].stringValue
      self.teamPoint = dict["point"].stringValue
      self.teamLose = dict["lose"].stringValue
      self.teamPosition = dict["position"].stringValue
      self.teameEtablished = dict["established"].stringValue
      self.teamManager = dict["manager"].stringValue
      self.teamNickName = dict["nickname"].stringValue
      self.teamStadium = dict["stadium"].stringValue
      self.teameClubUrl = dict["clubUrl"].stringValue
      self.leagueId = dict["leagueId"].stringValue
   }
   
}



