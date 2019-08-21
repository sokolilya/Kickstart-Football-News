//
//  CountryListCell.swift
//  UEFAEuro
//
//  Created by Nguyen Hieu on 3/19/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit

class CountryListCell: UITableViewCell {
    var positionNo: Int!
    

    @IBOutlet var lblRank: UILabel!
    @IBOutlet var imgCountry: UIImageView!
    @IBOutlet var imgCountryName: MarqueeLabel!
    @IBOutlet var lblPlayed: UILabel!
    @IBOutlet var lblWin: UILabel!
    @IBOutlet var lblDraw: UILabel!
    @IBOutlet var lblLost: UILabel!
    @IBOutlet var lblGoalDifference: UILabel!
    @IBOutlet var lblPoints: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgCountryName.text = "kStanCellTeam".localized
        lblPlayed.text = "kStanCellPlayer".localized
        lblWin.text = "kStanCellWon".localized
        lblDraw.text = "kStanCellDraw".localized
        lblLost.text = "kStanCellLost".localized
        lblGoalDifference.text = "kStanCellGoal".localized
        lblPoints.text = "kStanCellPoint".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupRankWithCountry(_ team: TeamInStandingObj){
        lblRank.text = team.teamPosition
        if let strImg = team.teamImage {
           imgCountry.kf.setImage(with: URL(string: strImg), placeholder: #imageLiteral(resourceName: "ic_unknown"), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            imgCountry.image = #imageLiteral(resourceName: "ic_unknown")
        }
        imgCountryName.text = team.teamName
        lblPlayed.text = team.teamPlayed
        lblWin.text = team.teamWin
        lblDraw.text = team.teamDraw
        lblLost.text = team.teamLose
        lblGoalDifference.text = team.teamGDiff
        lblPoints.text = team.teamPoint
        
    }
    func configureCellForItem(_ top: TeamObj){
        lblRank.text = String(format: "%d", positionNo)
        lblWin.text = top.WinID
        lblDraw.text = top.DrawID
        lblLost.text = top.LoseID
        lblPlayed.text = top.playerID
        lblPoints.text = top.PointID
        
        if positionNo < 4 {
            lblRank.textColor = UIColor.red
            imgCountryName.textColor = UIColor.red
            lblPlayed.textColor = UIColor.blue
            lblWin.textColor = UIColor.blue
            lblDraw.textColor = UIColor.blue
            lblLost.textColor = UIColor.blue
            lblPoints.textColor = UIColor.blue
            lblGoalDifference.textColor = UIColor.blue
        }
    }

}
