//
//  championsleague.swift
//  WORLDCUP
//
//  Created by HiCom on 8/6/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit

class championsleague: UITableViewCell {
    @IBOutlet var lblGroup: UILabel!
    @IBOutlet var lblStt: UILabel!
    @IBOutlet var lblTeam: UILabel!
    @IBOutlet var lblplayed: UILabel!
    @IBOutlet var lblWin: UILabel!
    @IBOutlet var lblDraw: UILabel!
    @IBOutlet var lbllost: UILabel!
    @IBOutlet var lblGoalDifference: UILabel!
    @IBOutlet var lblPoints: UILabel!
    var positionNo: Int!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupRankWithCountry(_ team1: TeamInStandingObj){
        lblStt.text = team1.teamPosition
        if let strImg = team1.teamImage {
        lblTeam.text = team1.teamName
        lblplayed.text = team1.teamPlayed
        lblWin.text = team1.teamWin
        lblDraw.text = team1.teamDraw
        lbllost.text = team1.teamLose
        lblGoalDifference.text = team1.teamGDiff
        lblPoints.text = team1.teamPoint
        
    }
    func configureCellForItem(_ top: TeamObj){
        lblStt.text = String(format: "%d", positionNo)
        lblWin.text = top.WinID
        lblDraw.text = top.DrawID
        lbllost.text = top.LoseID
        lblplayed.text = top.playerID
        lblPoints.text = top.PointID
    }
}
    
}


