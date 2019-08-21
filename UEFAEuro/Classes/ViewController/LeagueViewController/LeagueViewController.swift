//
//  LeagueViewController.swift
//  WORLDCUP
//
//  Created by Trung Ngo on 7/17/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit
import SMSwipeableTabView
import SMSwipeableTabView
import UserNotifications


class LeagueViewController: UIViewController, SMSwipeableTabViewControllerDelegate,UNUserNotificationCenterDelegate {
   let swipeableView = SMSwipeableTabViewController()
   let titleBarDataSource = ["RANK","SCHEDULE", "NEWS","SETTINGS"]
//   var TopScoreVC : TopScoreViewController!
   var NewVC : NewsViewController!
   var SettingVC: SettingsViewController!
   var scheduVC: ScheduleViewController!
   var RankVC: RankViewController!
   
   @IBOutlet weak var contrainNaviHeight: NSLayoutConstraint!
   @IBOutlet weak var constrainPaddingTop: NSLayoutConstraint!
    @IBOutlet var lblLeague: UILabel!
   @IBOutlet weak var btnRefresh: UIButton!
   @IBOutlet weak var imgRefresh: UIImageView!
   private var isRank = false
   private var isSchedu = false
   private var isTop = false
   private var isNew = false
   private var isSetting = false
   
   @IBAction func onRefresh(_ sender: Any) {
      if isRank {
       //  RankVC?.getdata()
         return
      }
      if isSchedu {
         scheduVC?.reloadData()
         return
      }
//      if isTop {
//         TopScoreVC?.getDataFromServer()
//         return
//      }
      if isNew{
         NewVC?.loadRSSData()
         return
      }
      if isSetting {
         print("aaaa")
         SettingVC.saveSetting()
      }
   }
   
    override func viewDidLoad() {
        super.viewDidLoad()
      if UIScreen.main.bounds.size.height == 812{
         contrainNaviHeight.constant = 88
         constrainPaddingTop.constant = 30
      }
         self.navigationController?.navigationBar.isHidden = true
        self.lblLeague.text = GlobalEntities.leagueName
        loadSwipeableView()
   
    }
   
   @available(iOS 10.0, *)
   func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      completionHandler([.alert, .badge, .sound])
   }
   
   func loadSwipeableView(){
//      TopScoreVC = storyboard?.instantiateViewController(withIdentifier: "TopScoreViewController") as! TopScoreViewController
    NewVC = storyboard?.instantiateViewController(withIdentifier: "NewsViewController") as? NewsViewController
    SettingVC = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
    scheduVC =  storyboard?.instantiateViewController(withIdentifier: "ScheduleViewController") as? ScheduleViewController
    RankVC =  storyboard?.instantiateViewController(withIdentifier: "RankViewController") as? RankViewController
    swipeableView.segmentBarAttributes = [SMBackgroundColorAttribute : UIColor.lightGray]
    swipeableView.selectionBarAttributes = [SMBackgroundColorAttribute : UIColor.gray]
    swipeableView.buttonAttributes = [SMForegroundColorAttribute : UIColor.darkGray]
      swipeableView.titleBarDataSource = titleBarDataSource
      swipeableView.buttonWidth = UIScreen.main.bounds.width/3;
      swipeableView.buttonPadding = 0;
      swipeableView.delegate = self
      swipeableView.view.frame = CGRect(x: 0.0, y: 64.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-64)
      if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone)
      {
         if (UIScreen.main.bounds.height == 812)
         {
            swipeableView.view.frame = CGRect(x: 0.0, y: 88.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 88)
         }
      }
      
    swipeableView.buttonAttributes = [NSAttributedString.Key.font.rawValue: Util.defaultNormalFont()]
    self.addChild(swipeableView)
      self.view.addSubview(swipeableView.view)
    swipeableView.didMove(toParent: self)
   }
   
   func didLoadViewControllerAtIndex(_ index: Int) -> UIViewController {
      switch index {
      case 0:
         isRank = true
        isSchedu = false
         isTop = false
          isNew = false
          self.imgRefresh.image = UIImage.init(named: "reload.png")
         isSetting = false
         
         return RankVC
         
      case 1:
         isRank = false
         isSchedu = true
         isTop = false
         isNew = false
         isSetting = false
          self.imgRefresh.image = UIImage.init(named: "reload.png")
         return scheduVC
         
//      case 2:
//         isRank = false
//         isSchedu = false
//         isTop = true
//         isNew = false
//         isSetting = false
//          self.imgRefresh.image = UIImage.init(named: "reload.png")
//         return TopScoreVC
        
      case 2:
         isRank = false
         isSchedu = false
         isTop = false
         isNew = true
         isSetting = false
          self.imgRefresh.image = UIImage.init(named: "reload.png")
         return NewVC
         
      case 3:
         isRank = false
         isSchedu = false
         isTop = false
         isNew = false
         isSetting = true
         self.imgRefresh.image = UIImage.init(named: "ic_save_white.png")
         return SettingVC
         
      default:
         isRank = false
         isSchedu = false
         isTop = false
         isNew = false
         isSetting = true
         self.imgRefresh.image = UIImage.init(named: "ic_save_white.png")
         return SettingVC
         
 

         
         
         
      }
   }
   
   @IBAction func onMenu(_ sender: Any) {
      self.slideMenuController()?.toggleLeft()
   }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
