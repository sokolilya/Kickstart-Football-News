//
//  CommentTableViewCell.swift
//  Euro2016
//
//  Created by Ngọc Toán on 2/9/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {


    @IBOutlet var lblTimecomment: UIView!
    @IBOutlet weak var lblDatePost: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
