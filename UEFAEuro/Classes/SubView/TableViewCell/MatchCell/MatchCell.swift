//
//  MatchCell.swift
//  UEFAEuro
//
//  Created by Nguyen Hieu on 3/25/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit
protocol MyCellDelegate {
    func didTapButton(_ objMatch: MatchObj!)
}

class MatchCell: UITableViewCell {
     var delegate: MyCellDelegate?
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHomeScore: UILabel!
    @IBOutlet weak var lblAwayScore: UILabel!
    @IBOutlet var constrainPenHomeWidth: NSLayoutConstraint!
    
    @IBOutlet var constrainPenAwayWidth: NSLayoutConstraint!
    
    @IBOutlet var lblHomeName: MarqueeLabel!
    @IBOutlet var lblAwayName: MarqueeLabel!
    
    @IBOutlet weak var btnAlarm: UIButton!
   @IBOutlet weak var lblTime: UILabel!
   @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet var lblPenhome: UILabel!
    @IBOutlet var lblPenaway: UILabel!
    
   
    var objMatch: MatchObj!
    override func awakeFromNib() {
        super.awakeFromNib()
        scheduleView.layer.cornerRadius = 5
        scheduleView.layer.shadowColor = Util.colorWithHexString("#000000").cgColor
        scheduleView.layer.shadowOpacity = 0.2
        scheduleView.layer.shadowOffset = CGSize.zero
        scheduleView.layer.shadowRadius = 4
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setDataForMatch(_ match:MatchObj){
        
        self.objMatch = match
        let strMatchId = objMatch.mId
      let userDefault = UserDefaults.standard
      if let saveAlarm = userDefault.string(forKey: String(format: "%@", KEY_SAVE_ALARM)){
         GlobalEntities.gArrReminder = saveAlarm.components(separatedBy: ",")
         if GlobalEntities.gArrReminder.contains(strMatchId){
            btnAlarm.isSelected = true
         }
         else{
            btnAlarm.isSelected = false
         }
      }
      
      
        if match.mStatus == "0" {
            btnAlarm.isHidden = false
        }else{
            btnAlarm.isHidden = true
        }
        
        if match.mawayPen == ""{
            constrainPenHomeWidth.constant = 0
            constrainPenAwayWidth.constant = 0
        }else{
            constrainPenHomeWidth.constant = 21
            constrainPenAwayWidth.constant = 21
        }
        self.lblPenaway.text = "(\(match.mawayPen))"
      self.lblPenhome.text = "(\(match.mhomePen))"
        let dateFormatter = DateFormatter()
      let timeFormatter = DateFormatter()
        let datePlay = Date(timeIntervalSince1970:Double(match.mTime)!)
        dateFormatter.dateFormat = "dd - MMM"
        let dateStr = dateFormatter.string(from: datePlay)
         let TimePlay = Date(timeIntervalSince1970:Double(match.mTime)!)
      timeFormatter.dateFormat = "HH:mm"
         let timeStr = timeFormatter.string(from: TimePlay)
        lblDate.text = dateStr
        lblDate.textColor = Util.colorWithHexString("39A3DB")
      if objMatch.mMinuteOver == "Postponed" || objMatch.mMinuteOver == "Cancelled" || objMatch.mMinuteOver == "Abandoned" {
         self.lblTime.text = self.objMatch.mMinuteOver
         imgStatus.isHidden = true
         self.lblTime.textColor = Util.colorWithHexString("39A3DB")
         
      }else{
        if objMatch.mStatus == "1" {
            imgStatus.isHidden = false
            imgStatus.image = UIImage(named: "ic_greenLive.png")
            self.lblTime.text = "kDetailMatchLive:".localized + ", " + objMatch.mMinuteOver + "'"
         self.lblTime.textColor = Util.colorWithHexString("39A3DB")
        }
         if objMatch.mStatus == "2"{
                    imgStatus.isHidden = false
            imgStatus.image = UIImage(named: "ic_grayFinish.png")
           self.lblTime.text = "FINISH"
            self.lblTime.textColor = Util.colorWithHexString("39A3DB")
        }
        
         if objMatch.mStatus == "0" {
        imgStatus.isHidden = true
         self.lblTime.text = timeStr
         self.lblTime.textColor = Util.colorWithHexString("39A3DB")
         }
      }
      
      
      lblHomeName.text = match.mHomeName.localized
        if match.mAwayScore.count > 0 {
         if match.mStatus == "0"{
            lblAwayScore.text = "?"
            lblHomeScore.text = "?"
         }else{
            lblAwayScore.text = match.mAwayScore
            lblHomeScore.text = match.mHomeScore
         }
        }else{
            lblAwayScore.text = "?"
            lblHomeScore.text = "?"
        }
        lblAwayName.text = match.mAwayName.localized
    }
    @IBAction func onSetupAlarm(_ sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.didTapButton(self.objMatch)
        }
    }
   
  
}
