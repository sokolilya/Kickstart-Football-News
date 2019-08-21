//
//  LineUpTreeTableViewCell.swift
//  UEFAEuro
//
//  Created by HiCom on 4/12/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit

class LineUpTreeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNameHomePlayer: UILabel!
    @IBOutlet weak var lblTypeHomePlayer: UILabel!
    @IBOutlet weak var lblTypeAwayPlayer: UILabel!
    @IBOutlet weak var lblNameAwayPlayer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
