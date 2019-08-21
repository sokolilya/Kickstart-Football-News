//
//  TimeLineTableVCCell.swift
//  UEFAEuro
//
//  Created by HiCom on 4/6/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit

class TimeLineTableVCCell: UITableViewCell {
    
    
    @IBOutlet weak var lblNameEventTeamA: UILabel!

    @IBOutlet weak var lblTimeEventTeamA: UILabel!
    
    @IBOutlet weak var imgEventTeamA: UIImageView!
    @IBOutlet weak var lblNameEventTeamB: UILabel!
    @IBOutlet weak var lblTimeEventTeamB: UILabel!
    @IBOutlet weak var imgEventTeamB: UIImageView!
   @IBOutlet weak var constrainLineCenterBot: NSLayoutConstraint!
   
   @IBOutlet weak var imgHideBot: UIImageView!
   
    
    @IBOutlet weak var imgHiddenWhenCell01: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ objEvent: EventObj){
    
    }
    

}
