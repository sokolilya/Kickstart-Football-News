//
//  NewsCell.swift
//  UEFAEuro
//
//  Created by tuan vn on 4/2/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {

    @IBOutlet weak var feedTimePost: UILabel!
    @IBOutlet weak var feedDescription: UILabel!
    @IBOutlet weak var feedTitle: UILabel!
    @IBOutlet weak var imgFeed: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    
    func configCell(_ objFeed: RssRecord, imgUrl: String){
        feedTitle.text = objFeed.title
        feedDescription.text = objFeed.description
        feedDescription.isHidden = true
        imgFeed.kf.setImage(with: (URL(string: imgUrl)))
        
        let str = objFeed.pubDate
        
        let indexDateString = str.index(str.startIndex, offsetBy: 25)
        let dateString = str[..<indexDateString]
        
        let indexTimeZone = str.index(str.endIndex, offsetBy: -3)
        let timeZone = str[indexTimeZone...]
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: String(timeZone)) //Set timezone that you want
        var date = dateFormatter.date(from: String(dateString))
        var dateStamp:TimeInterval = date!.timeIntervalSince1970
        var dateSt:Int = Int(dateStamp)
        
        let dateFinal = Date(timeIntervalSince1970: TimeInterval(dateSt))
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        dateFormatter.timeZone = TimeZone(abbreviation: localTimeZoneAbbreviation) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEE, dd MMM yyyy" //Specify your format that you want
        feedTimePost.text = dateFormatter.string(from: dateFinal)
  
    }
}

