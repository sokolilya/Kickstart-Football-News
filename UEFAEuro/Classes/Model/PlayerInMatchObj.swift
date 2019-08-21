//
//  PlayerInMatchObj.swift
//  UEFAEuro
//
//  Created by HiCom on 4/10/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit
import SwiftyJSON

struct PlayerInMatchObj {
    let playerId: String
    let playerMatchId: String
    let playerClupId: String
    let playerName: String
    let playerPositon: String
    let playerNumber: String
    init(dict: JSON) {
        self.playerId = dict["id"].stringValue
        self.playerMatchId = dict["matchId"].stringValue
        self.playerClupId = dict["clubId"].stringValue
        self.playerName = dict["name"].stringValue
        self.playerPositon = dict["position"].stringValue
        self.playerNumber = dict["number"].stringValue
    }
}
