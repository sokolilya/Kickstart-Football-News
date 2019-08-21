//
//  SettingsCell.swift
//  UEFAEuro
//
//  Created by tuan vn on 4/2/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var imageChecked: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var teamEdit: TeamInSetting?
   
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureForCell(_ team: TeamInSetting){
        teamEdit = team
        configureCheckBox(team.teamSelected)
        nameLabel.text = team.teamName.localized

    }
   

    @IBAction func touchChecked(_ sender: AnyObject) {
      if let teamEdit = teamEdit {
            teamEdit.teamSelected = !teamEdit.teamSelected
            configureCheckBox(teamEdit.teamSelected)
        }
        
    }
    
    func configureCheckBox(_ checked: Bool){
        if checked {
            imageChecked.image = UIImage(named: "setting_checked")
        }else{
            imageChecked.image = UIImage(named: "setting_unchecked")
        }
    }
   

}
