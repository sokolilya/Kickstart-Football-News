//
//  DropDownTableViewCell.swift
//  Euro2016
//
//  Created by Ngọc Toán on 2/13/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
    @IBOutlet weak var imgFlagCountry: UIImageView!
    
    @IBOutlet weak var lblNameCountry: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
