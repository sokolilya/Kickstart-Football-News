//
//  TopScoreCell.swift
//  UEFAEuro
//
//  Created by tuan vn on 4/2/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit

class TopScoreCell: UITableViewCell {

    @IBOutlet weak var indexLabel: UILabel!
   
    @IBOutlet weak var namePlayer: UILabel!
    @IBOutlet weak var scoreCountLabel: UILabel!
    var positionNo: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    
    }

    func configureCellForItem(_ top: PlayerTopScoreObj){
        indexLabel.text = String(format: "%d", positionNo)
        namePlayer.text = top.playerName
        scoreCountLabel.text = top.playerGoal
       
        if positionNo < 4 {
            indexLabel.textColor = UIColor(red: 222/255.0, green: 12/255.0, blue: 21/255.0, alpha: 1.0)
            namePlayer.textColor = UIColor(red: 222/255.0, green: 12/255.0, blue: 21/255.0, alpha: 1.0)
            scoreCountLabel.textColor = UIColor(red: 222/255.0, green: 12/255.0, blue: 21/255.0, alpha: 1.0)
        }else{
            indexLabel.textColor = UIColor(red: 114/255.0, green: 114/255.0, blue: 114/255.0, alpha: 1.0)
            namePlayer.textColor = UIColor(red: 114/255.0, green: 114/255.0, blue: 114/255.0, alpha: 1.0)
            scoreCountLabel.textColor = UIColor(red: 114/255.0, green: 114/255.0, blue: 114/255.0, alpha: 1.0)
        }
        
    }

}
