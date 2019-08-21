//
//  MatchObj.swift
//  Euro2016
//
//  Created by Ngọc Toán on 1/17/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//
import UIKit
import SwiftyJSON

struct MatchObj {
    var mLeagueId:String
    var mTypeId: String
    var mId: String
    var mHomeId: String
    var mHomeName: String
    var mHomeImage: String
    var mAwayId: String
    var mAwayName: String
    var mAwayImage: String
    var mHomeScore: String
    var mAwayScore: String
    var mStadiumName: String
    var mTime: String
    var mStatus: String
    var mMinuteOver: String
    var mGroupId: String
    var mGroupName: String
    var mRound: String
    var mhomePen: String
    var mawayPen: String
    
    
   
    init(dict: JSON) {
        self.mTypeId = dict["typeId"].stringValue
        self.mLeagueId = dict["leagueId"].stringValue
        self.mStadiumName = dict["stadium"].stringValue
        self.mStatus = dict["status"].stringValue
        self.mTime = dict["time"].stringValue
        self.mAwayId = dict["away"].stringValue
        self.mAwayImage = dict["awayImage"].stringValue
        self.mAwayName = dict["awayName"].stringValue
        let score11 = dict["awayScore"].stringValue
        
        if score11.count > 0 {
            self.mAwayScore = score11
        }else{
            self.mAwayScore = ""
        }
         self.mRound = dict["round"].stringValue
        self.mGroupId = dict["groupId"].stringValue
        self.mGroupName = dict["group"].stringValue
        self.mHomeId = dict["home"].stringValue
        self.mHomeImage = dict["homeImage"].stringValue
        self.mHomeName = dict["homeName"].stringValue
        self.mHomeScore = dict["homeScore"].stringValue
        self.mId = dict["id"].stringValue
        self.mhomePen = dict["homePen"].stringValue
        self.mawayPen = dict["awayPen"].stringValue
        let minute = dict["minute"].stringValue
        if minute.count > 0 {
            self.mMinuteOver = minute
        }
        else{
            self.mMinuteOver = ""
        }
    }
}
