//
//  EventObj.swift
//  UEFAEuro
//
//  Created by HiCom on 4/8/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit
import SwiftyJSON

struct EventObj {

    let eventID: String
    let eventMatchId: String
    let eventPlayer: String
    let eventClupId: String
    let eventMinute: String
    let eventScore: String
    let eventType: String
    let eventCurrentScore: String
    init(dict: JSON) {
        self.eventID = dict["id"].stringValue
        self.eventMatchId = dict["matchId"].stringValue
        self.eventPlayer = dict["player"].stringValue
        self.eventClupId = dict["clubId"].stringValue
        self.eventMinute = dict["minute"].stringValue
        self.eventScore = dict["score"].stringValue
        self.eventType = dict["type"].stringValue
        self.eventCurrentScore = dict["currentScore"].stringValue
    }
}
