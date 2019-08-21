//
//  GroupCell.swift
//  UEFAEuro
//
//  Created by Nguyen Hieu on 3/19/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var lblGroupName: UILabel!
    
    
    @IBOutlet var groupView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupDataForGroup(_ group: GroupObj){
        groupView.layer.cornerRadius = 8
        groupView.layer.shadowColor = Util.colorWithHexString("#000000").cgColor
        groupView.layer.shadowOpacity = 0.2
        groupView.layer.shadowOffset = CGSize.zero
        groupView.layer.shadowRadius = 4
        lblGroupName.text = group.groupName
        
        for index in 0..<group.groupArrClup.count{
            let objClubCurrent = group.groupArrClup[index]
//            for objClub in GlobalEntities.gArrObjTeams {
//                if country == objClub.teamName {
                    for view in self.groupView.subviews {
                        if let label = view as? UILabel {
                            if label.tag == index{
                                label.text =  objClubCurrent.clubFiFaCode
                                
                            }
                        }
                        if let image = view as? UIImageView {
                            if image.tag == index{
                                 image.kf.setImage(with: URL(string: objClubCurrent.clubImage), placeholder: #imageLiteral(resourceName: "ic_unknown"), options: nil, progressBlock: nil, completionHandler: nil)
                            }
                            
                        }
                        
                    }
//                }
//            }
            
            
            
        }
    }
}
