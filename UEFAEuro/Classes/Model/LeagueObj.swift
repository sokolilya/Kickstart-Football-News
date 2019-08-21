//
//  LeagueObj.swift
//  WORLDCUP
//
//  Created by Trung Ngo on 7/14/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit
import SwiftyJSON

class LeagueObj: NSObject {
   var leagueId: String!
   var leagueName: String!
   var leagueImage: String!
   var leagueStatus: String!
   var leagueTypeId: String!
   init(dict: JSON) {
      self.leagueId = dict["id"].stringValue
      self.leagueName = dict["name"].stringValue
      self.leagueImage = dict["image"].stringValue
      self.leagueStatus = dict["status"].stringValue
      self.leagueTypeId = dict["type"].stringValue
   }
}


