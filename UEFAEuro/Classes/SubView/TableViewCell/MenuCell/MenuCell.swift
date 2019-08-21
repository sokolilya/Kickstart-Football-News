//
//  MenuCell.swift
//  UEFAEuro
//
//  Created by Nguyen Hieu on 3/19/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var icMenu: UIImageView!
    @IBOutlet weak var lblMenuName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }
    func setupCellWithImageName(_ name:String, title:String){
        icMenu.image = UIImage(named: name)
        lblMenuName.text = title
        lblMenuName.textColor = MyColors.colorText()
    }
    
}
