//
//  SetAlarmVC.swift
//  UEFAEuro
//
//  Created by HiCom on 4/11/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit
import EventKit
import UserNotifications

enum TimeChosen: Int {
    case onTime = 0
    case on30Minutes
    case on60Minutes
    case on2Hours
    
}
protocol AlarmDeleGate: AnyObject {
   func reloadAfterSave()
}

class SetAlarmVC: UIViewController, UNUserNotificationCenterDelegate {
    var objMatch: MatchObj!
    var dateAlarm: Date!
    var dateThumbnail: Date!
    var strTitleAlarm: String!
   var dateThumbnail15: Date!
   var strTitleAlarm15: String!
   var dateThumbnail30: Date!
   var strTitleAlarm30: String!
   var dateThumbnail60: Date!
   var strTitleAlarm60: String!
    var delegate: AlarmDeleGate?
    
    @IBOutlet weak var lbl30Minbefore: UILabel!
    
    @IBOutlet weak var lbl2HoursBefore: UILabel!
    @IBOutlet weak var lbl60MinBefore: UILabel!
    @IBOutlet weak var lblOntime: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!

    @IBOutlet weak var btnOnTime: UIButton!
    
    @IBOutlet weak var btn30Minutes: UIButton!
    
    @IBOutlet weak var btn60Minutes: UIButton!
    
    @IBOutlet weak var btn2Hours: UIButton!
    
    @IBOutlet weak var btnOk: UIButton!
    
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBAction func onSave(_ sender: AnyObject) {
      if #available(iOS 10.0, *) {
         if self.btnOnTime.isSelected {
                     let content = UNMutableNotificationContent()
                     content.title = "kAppName".localized
                     content.body = self.strTitleAlarm
                     content.badge = 1
            content.sound = UNNotificationSound.default
                     let timestamp = NSDate().timeIntervalSince1970
                     let current = TimeInterval(timestamp)
                     let time = Double(objMatch.mTime)! - current
                     let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
                     UNUserNotificationCenter.current().delegate = self
                     let userDefault = UserDefaults.standard
                     if let saveAlarm = userDefault.string(forKey: String(format: "%@", KEY_SAVE_ALARM)){
                        print(saveAlarm)
                        GlobalEntities.gArrReminder = saveAlarm.components(separatedBy: ",")
                     if GlobalEntities.gArrReminder.contains(self.objMatch.mId){
                     userDefault.set("YES", forKey: String(format: "%@", self.objMatch.mId))
                     
                     }else{
                       var strClubId = saveAlarm
                       strClubId = strClubId + "," + self.objMatch.mId
                       userDefault.set(strClubId, forKey: String(format: "%@", KEY_SAVE_ALARM))
                       userDefault.set("YES", forKey: String(format: "%@", self.objMatch.mId))
                     }
                     
                     }else{
                     print("abc")
                     userDefault.set(self.objMatch.mId, forKey: String(format: "%@", KEY_SAVE_ALARM))
                     userDefault.set("YES", forKey: String(format: "%@", self.objMatch.mId))
                     }
                     
                     let request = UNNotificationRequest(identifier: String(format: "%@", self.objMatch.mId), content: content, trigger: trigger)
                     UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
         }else{
            let userDefault = UserDefaults.standard
            userDefault.set("NO", forKey: String(format: "%@", self.objMatch.mId))
             UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [String(format: "%@", self.objMatch.mId)])
         }
         
         // Btn30 Select
         if self.btn30Minutes.isSelected {
            let content = UNMutableNotificationContent()
            content.title = "kAppName".localized
            content.body = self.strTitleAlarm15
            content.badge = 1
            content.sound = UNNotificationSound.default
            let timestamp = NSDate().timeIntervalSince1970
            let current = TimeInterval(timestamp)
            let time = Double(objMatch.mTime)! + 15*60 - current
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
            UNUserNotificationCenter.current().delegate = self
            let userDefault = UserDefaults.standard
            if let saveAlarm = userDefault.string(forKey: String(format: "%@", KEY_SAVE_ALARM)){
               print(saveAlarm)
               GlobalEntities.gArrReminder = saveAlarm.components(separatedBy: ",")
               if GlobalEntities.gArrReminder.contains(self.objMatch.mId){
                  userDefault.set("YES", forKey: String(format: "%@_15", self.objMatch.mId))
                  
               }else{
                  var strClubId = saveAlarm
                  strClubId = strClubId + "," + self.objMatch.mId
                  userDefault.set(strClubId, forKey: String(format: "%@", KEY_SAVE_ALARM))
                  userDefault.set("YES", forKey: String(format: "%@_15", self.objMatch.mId))
               }
               
            }else{
               print("abc")
               userDefault.set(self.objMatch.mId, forKey: String(format: "%@", KEY_SAVE_ALARM))
               userDefault.set("YES", forKey: String(format: "%@_15", self.objMatch.mId))
            }
            
            let request = UNNotificationRequest(identifier: String(format: "%@_15", self.objMatch.mId), content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
         }else{
            let userDefault = UserDefaults.standard
            userDefault.set("NO", forKey: String(format: "%@_15", self.objMatch.mId))
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [String(format: "%@_15", self.objMatch.mId)])
         }
         
         
         //Btn60 Select
         if self.btn60Minutes.isSelected {
            let content = UNMutableNotificationContent()
            content.title = "kAppName".localized
            content.body = self.strTitleAlarm30
            content.badge = 1
            content.sound = UNNotificationSound.default
            let timestamp = NSDate().timeIntervalSince1970
            let current = TimeInterval(timestamp)
            let time = Double(objMatch.mTime)! + 30*60 - current
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
            UNUserNotificationCenter.current().delegate = self
            let userDefault = UserDefaults.standard
            if let saveAlarm = userDefault.string(forKey: String(format: "%@", KEY_SAVE_ALARM)){
               print(saveAlarm)
               GlobalEntities.gArrReminder = saveAlarm.components(separatedBy: ",")
               if GlobalEntities.gArrReminder.contains(self.objMatch.mId){
                  userDefault.set("YES", forKey: String(format: "%@_30", self.objMatch.mId))
                  
               }else{
                  var strClubId = saveAlarm
                  strClubId = strClubId + "," + self.objMatch.mId
                  userDefault.set(strClubId, forKey: String(format: "%@", KEY_SAVE_ALARM))
                  userDefault.set("YES", forKey: String(format: "%@_30", self.objMatch.mId))
               }
               
            }else{
               print("abc")
               userDefault.set(self.objMatch.mId, forKey: String(format: "%@", KEY_SAVE_ALARM))
               userDefault.set("YES", forKey: String(format: "%@_30", self.objMatch.mId))
            }
            
            let request = UNNotificationRequest(identifier: String(format: "%@_30", self.objMatch.mId), content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
         }else{
            let userDefault = UserDefaults.standard
            userDefault.set("NO", forKey: String(format: "%@_30", self.objMatch.mId))
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [String(format: "%@_30", self.objMatch.mId)])
         }
         
         
         //Btn2Hourse select
         if self.btn2Hours.isSelected {
            let content = UNMutableNotificationContent()
            content.title = "kAppName".localized
            content.body = self.strTitleAlarm60
            content.badge = 1
            content.sound = UNNotificationSound.default
            let timestamp = NSDate().timeIntervalSince1970
            let current = TimeInterval(timestamp)
            let time = Double(objMatch.mTime)! + 60*60 - current
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
            UNUserNotificationCenter.current().delegate = self
            let userDefault = UserDefaults.standard
            if let saveAlarm = userDefault.string(forKey: String(format: "%@", KEY_SAVE_ALARM)){
               print(saveAlarm)
               GlobalEntities.gArrReminder = saveAlarm.components(separatedBy: ",")
               if GlobalEntities.gArrReminder.contains(self.objMatch.mId){
                  userDefault.set("YES", forKey: String(format: "%@_60", self.objMatch.mId))
                  
               }else{
                  var strClubId = saveAlarm
                  strClubId = strClubId + "," + self.objMatch.mId
                  userDefault.set(strClubId, forKey: String(format: "%@", KEY_SAVE_ALARM))
                  userDefault.set("YES", forKey: String(format: "%@_60", self.objMatch.mId))
               }
               
            }else{
               print("abc")
               userDefault.set(self.objMatch.mId, forKey: String(format: "%@", KEY_SAVE_ALARM))
               userDefault.set("YES", forKey: String(format: "%@_60", self.objMatch.mId))
            }
            
            let request = UNNotificationRequest(identifier: String(format: "%@_60", self.objMatch.mId), content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
         }else{
            let userDefault = UserDefaults.standard
            userDefault.set("NO", forKey: String(format: "%@_60", self.objMatch.mId))
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [String(format: "%@_60", self.objMatch.mId)])
         }
         
         
      }else {
         if btnOnTime.isSelected{
            let notification = UILocalNotification()
            notification.alertBody = self.strTitleAlarm
            notification.alertAction = "open"
            let timestamp = NSDate().timeIntervalSince1970
            let current = TimeInterval(timestamp)
            let time = Double(objMatch.mTime)! - current
            notification.fireDate = Date(timeIntervalSinceNow: time)
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.userInfo = ["title": "kAppName".localized, "UUID": String(format: "%@", self.objMatch.mId)]
            UIApplication.shared.scheduleLocalNotification(notification)
            let userDefault = UserDefaults.standard
            if let saveAlarm = userDefault.string(forKey: String(format: "%@", KEY_SAVE_ALARM)){
               print(saveAlarm)
               GlobalEntities.gArrReminder = saveAlarm.components(separatedBy: ",")
               if GlobalEntities.gArrReminder.contains(self.objMatch.mId){
                  userDefault.set("YES", forKey: String(format: "%@", self.objMatch.mId))
                  
               }else{
                  var strClubId = saveAlarm
                  strClubId = strClubId + "," + self.objMatch.mId
                  userDefault.set(strClubId, forKey: String(format: "%@", KEY_SAVE_ALARM))
                  userDefault.set("YES", forKey: String(format: "%@", self.objMatch.mId))
               }
               
            }else{
               print("abc")
               userDefault.set(self.objMatch.mId, forKey: String(format: "%@", KEY_SAVE_ALARM))
               userDefault.set("YES", forKey: String(format: "%@", self.objMatch.mId))
            }
         }else{
            let notification = UILocalNotification()
            let userDefault = UserDefaults.standard
            userDefault.set("NO", forKey: String(format: "%@_15", self.objMatch.mId))
            notification.userInfo = ["title": "kAppName".localized , "UUID": String(format: "%@", self.objMatch.mId)]
            UIApplication.shared.cancelLocalNotification(notification)
         }
         
         //btn30Selected
         if btn30Minutes.isSelected{
            let notification = UILocalNotification()
            notification.alertBody = self.strTitleAlarm15
            notification.alertAction = "open"
            let timestamp = NSDate().timeIntervalSince1970
            let current = TimeInterval(timestamp)
            let time = Double(objMatch.mTime)! + 15*60 - current
            notification.fireDate = Date(timeIntervalSinceNow: time)
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.userInfo = ["title": "kAppName".localized, "UUID": String(format: "%@_15", self.objMatch.mId)]
            UIApplication.shared.scheduleLocalNotification(notification)
            let userDefault = UserDefaults.standard
            if let saveAlarm = userDefault.string(forKey: String(format: "%@", KEY_SAVE_ALARM)){
               print(saveAlarm)
               GlobalEntities.gArrReminder = saveAlarm.components(separatedBy: ",")
               if GlobalEntities.gArrReminder.contains(self.objMatch.mId){
                  userDefault.set("YES", forKey: String(format: "%@_15", self.objMatch.mId))
                  
               }else{
                  var strClubId = saveAlarm
                  strClubId = strClubId + "," + self.objMatch.mId
                  userDefault.set(strClubId, forKey: String(format: "%@", KEY_SAVE_ALARM))
                  userDefault.set("YES", forKey: String(format: "%@_15", self.objMatch.mId))
               }
               
            }else{
               print("abc")
               userDefault.set(self.objMatch.mId, forKey: String(format: "%@", KEY_SAVE_ALARM))
               userDefault.set("YES", forKey: String(format: "%@_15", self.objMatch.mId))
            }
         }else{
            let notification = UILocalNotification()
            let userDefault = UserDefaults.standard
            userDefault.set("NO", forKey: String(format: "%@_15", self.objMatch.mId))
            notification.userInfo = ["title": "kAppName".localized , "UUID": String(format: "%@_15", self.objMatch.mId)]
            UIApplication.shared.cancelLocalNotification(notification)
         }
         
         
         
         //btn60Select
         if btn60Minutes.isSelected{
            let notification = UILocalNotification()
            notification.alertBody = self.strTitleAlarm30
            notification.alertAction = "open"
            let timestamp = NSDate().timeIntervalSince1970
            let current = TimeInterval(timestamp)
            let time = Double(objMatch.mTime)! + 30*60 - current
            notification.fireDate = Date(timeIntervalSinceNow: time)
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.userInfo = ["title": "kAppName".localized, "UUID": String(format: "%@_30", self.objMatch.mId)]
            UIApplication.shared.scheduleLocalNotification(notification)
            let userDefault = UserDefaults.standard
            if let saveAlarm = userDefault.string(forKey: String(format: "%@", KEY_SAVE_ALARM)){
               print(saveAlarm)
               GlobalEntities.gArrReminder = saveAlarm.components(separatedBy: ",")
               if GlobalEntities.gArrReminder.contains(self.objMatch.mId){
                  userDefault.set("YES", forKey: String(format: "%@_30", self.objMatch.mId))
                  
               }else{
                  var strClubId = saveAlarm
                  strClubId = strClubId + "," + self.objMatch.mId
                  userDefault.set(strClubId, forKey: String(format: "%@", KEY_SAVE_ALARM))
                  userDefault.set("YES", forKey: String(format: "%@_30", self.objMatch.mId))
               }
               
            }else{
               print("abc")
               userDefault.set(self.objMatch.mId, forKey: String(format: "%@", KEY_SAVE_ALARM))
               userDefault.set("YES", forKey: String(format: "%@_30", self.objMatch.mId))
            }
         }else{
            let notification = UILocalNotification()
            let userDefault = UserDefaults.standard
            userDefault.set("NO", forKey: String(format: "%@_30", self.objMatch.mId))
            notification.userInfo = ["title": "kAppName".localized , "UUID": String(format: "%@_30", self.objMatch.mId)]
            UIApplication.shared.cancelLocalNotification(notification)
         }
         
         
         //Btn2hourse Selected
         if btn2Hours.isSelected{
            let notification = UILocalNotification()
            notification.alertBody = self.strTitleAlarm60
            notification.alertAction = "open"
            let timestamp = NSDate().timeIntervalSince1970
            let current = TimeInterval(timestamp)
            let time = Double(objMatch.mTime)! + 60*60 - current
            notification.fireDate = Date(timeIntervalSinceNow: time)
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.userInfo = ["title": "kAppName".localized, "UUID": String(format: "%@_60", self.objMatch.mId)]
            UIApplication.shared.scheduleLocalNotification(notification)
            let userDefault = UserDefaults.standard
            if let saveAlarm = userDefault.string(forKey: String(format: "%@", KEY_SAVE_ALARM)){
               print(saveAlarm)
               GlobalEntities.gArrReminder = saveAlarm.components(separatedBy: ",")
               if GlobalEntities.gArrReminder.contains(self.objMatch.mId){
                  userDefault.set("YES", forKey: String(format: "%@_60", self.objMatch.mId))
                  
               }else{
                  var strClubId = saveAlarm
                  strClubId = strClubId + "," + self.objMatch.mId
                  userDefault.set(strClubId, forKey: String(format: "%@", KEY_SAVE_ALARM))
                  userDefault.set("YES", forKey: String(format: "%@_60", self.objMatch.mId))
               }
               
            }else{
               print("abc")
               userDefault.set(self.objMatch.mId, forKey: String(format: "%@", KEY_SAVE_ALARM))
               userDefault.set("YES", forKey: String(format: "%@_60", self.objMatch.mId))
            }
         }else{
            let notification = UILocalNotification()
            let userDefault = UserDefaults.standard
            userDefault.set("NO", forKey: String(format: "%@_60", self.objMatch.mId))
            notification.userInfo = ["title": "kAppName".localized , "UUID": String(format: "%@_60", self.objMatch.mId)]
            UIApplication.shared.cancelLocalNotification(notification)
         }
      }
      if !btnOnTime.isSelected && !btn30Minutes.isSelected && !btn60Minutes.isSelected && !btn2Hours.isSelected {
         let userDefault = UserDefaults.standard
         if let saveAlarm = userDefault.string(forKey: String(format: "%@", KEY_SAVE_ALARM)){
            let strString = saveAlarm
            let newString = strString.replacingOccurrences(of: String(format: "%@", self.objMatch.mId), with: " ")
            userDefault.set(newString, forKey: String(format: "%@", KEY_SAVE_ALARM))
         }
         DispatchQueue.main.async {
            self.delegate?.reloadAfterSave()
         }
      }else{
         
         DispatchQueue.main.async {
            self.delegate?.reloadAfterSave()
         }
      }
      
    
      
        removeAnimate()
    }

    @IBAction func onCancel(_ sender: AnyObject) {
        removeAnimate()
    }
    func showInView(_ aView:UIViewController, animated:Bool){
        aView.view.addSubview(self.view)
        aView.addChild(self)
        if animated == true{
            self.showAnimate()
        }
    }
    func showAnimate(){
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0;
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.view.alpha = 1;
            self.view.transform = CGAffineTransform(scaleX: 1, y: 1);
        }) 
    }
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0;
        }, completion: { (finished) -> Void in
            if finished == true{
                self.view.removeFromSuperview()
                self.navigationController?.popViewController(animated: false)
            }
        }) 
    }
    @IBAction func onSelectTimeAlarm(_ sender: AnyObject) {
        switch sender.tag {
        case TimeChosen.onTime.rawValue:
            dateThumbnail = Date(timeInterval: 0, since: dateAlarm)
            strTitleAlarm = "The match".localized + " " + objMatch.mHomeName.localized + " - " + objMatch.mAwayName.localized + " " + "will be starting".localized
            btnOnTime.isSelected = !btnOnTime.isSelected
            break
        case TimeChosen.on30Minutes.rawValue:
            dateThumbnail15 = Date(timeInterval: -15*60, since: dateAlarm)
            strTitleAlarm15 = "The match".localized + " " + objMatch.mHomeName.localized + " - " + objMatch.mAwayName.localized + " " + "will start in 30 minutes".localized
            btn30Minutes.isSelected = !btn30Minutes.isSelected

            break
        case TimeChosen.on60Minutes.rawValue:
            dateThumbnail30 = Date(timeInterval: -30*60, since: dateAlarm)
            strTitleAlarm30 = "The match".localized + " " + objMatch.mHomeName.localized + " - " + objMatch.mAwayName.localized + " " + "will start in 60 minutes".localized
            btn60Minutes.isSelected = !btn60Minutes.isSelected
            
            break
        case TimeChosen.on2Hours.rawValue:
            dateThumbnail60 = Date(timeInterval: -60*60, since: dateAlarm)
            strTitleAlarm60 = "The match".localized + " " + objMatch.mHomeName.localized + " - " + objMatch.mAwayName.localized + " " + "will start in 2 hours".localized
            btn2Hours.isSelected = !btn2Hours.isSelected
            break
        default:
            
            break
        }
        
    }
   
   
   
   @available(iOS 10.0, *)
   func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      completionHandler([.alert, .badge, .sound])
   }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblOntime.text = "kAlarmLblOnTime".localized
        lbl30Minbefore.text = "kAlarmLbl30Min".localized
        lbl60MinBefore.text = "kAlarmLbl60Min".localized
        lbl2HoursBefore.text = "kAlarmLbl2Hours".localized
        btnOnTime.isSelected = false
        btn30Minutes.isSelected = false
        btn60Minutes.isSelected = false
        btn2Hours.isSelected = false
        btnOk.setTitle("SAVE".localized, for:UIControl.State())
        btnCancel.setTitle("CANCEL".localized, for: UIControl.State())
      let dateFormater = DateFormatter()
      dateFormater.dateFormat = "EEE, MMM dd, yyyy HH:mm"
      dateAlarm = Date(timeIntervalSince1970: Double(objMatch.mTime)!)
      strTitleAlarm = "The match".localized + " " + objMatch.mHomeName.localized + " - " + objMatch.mAwayName.localized + " " + "will be starting".localized
      dateThumbnail = dateAlarm
      let strDate =  dateFormater.string(from: dateAlarm)
      lblTime.text = strDate
      dateThumbnail = Date(timeInterval: 0, since: dateAlarm)
      strTitleAlarm = "The match".localized + " " + objMatch.mHomeName.localized + " - " + objMatch.mAwayName.localized + " " + "will be starting".localized
      dateThumbnail15 = Date(timeInterval: -15*60, since: dateAlarm)
      strTitleAlarm15 = "The match".localized + " " + objMatch.mHomeName.localized + " - " + objMatch.mAwayName.localized + " " + "will start in 30 minutes".localized
      dateThumbnail30 = Date(timeInterval: -30*60, since: dateAlarm)
      strTitleAlarm30 = "The match".localized + " " + objMatch.mHomeName.localized + " - " + objMatch.mAwayName.localized + " " + "will start in 60 minutes".localized
      dateThumbnail60 = Date(timeInterval: -60*60, since: dateAlarm)
      strTitleAlarm60 = "The match".localized + " " + objMatch.mHomeName.localized + " - " + objMatch.mAwayName.localized + " " + "will start in 2 hours".localized
      
         let userDefault = UserDefaults.standard
      if let saveAlarm = userDefault.string(forKey: String(format: "%@", self.objMatch.mId)){
         if saveAlarm == "YES"{
            btnOnTime.isSelected = true
         }
         else{
            btnOnTime.isSelected = false
         }
      }
      if let saveAlarm15 = userDefault.string(forKey: String(format: "%@_15", self.objMatch.mId)){
         if saveAlarm15 == "YES"{
            btn30Minutes.isSelected = true
         }
         else{
            btn30Minutes.isSelected = false
         }
      }
      if let saveAlarm30 = userDefault.string(forKey: String(format: "%@_30", self.objMatch.mId)){
         if saveAlarm30 == "YES"{
            btn60Minutes.isSelected = true
         }
         else{
            btn60Minutes.isSelected = false
         }
      }
      if let saveAlarm60 = userDefault.string(forKey: String(format: "%@_60", self.objMatch.mId)){
         if saveAlarm60 == "YES"{
            btn2Hours.isSelected = true
         }
         else{
            btn2Hours.isSelected = false
         }
      }
      
      
      
    
    }

}
