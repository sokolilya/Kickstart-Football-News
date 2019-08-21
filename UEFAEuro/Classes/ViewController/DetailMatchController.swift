//
//  DetailMatchController.swift
//  UEFAEuro
//
//  Created by HiCom on 4/6/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit
import SMSwipeableTabView
import GoogleMobileAds
import UserNotifications

class DetailMatchController: UIViewController, SMSwipeableTabViewControllerDelegate, UNUserNotificationCenterDelegate{
    var objMatch: MatchObj!
    let swipeableView = SMSwipeableTabViewController()
    let titleBarDataSource = ["kTimeline".localized,
                              "kLineUp".localized,
                              "kComment".localized]
   let titleBarDataSource1 = ["kTimeline".localized,
                             "kComment".localized]
   
    var lineUpVC : LineUpTreeTableViewController!
    var timeLineVC : TimeLineTableVC!
    var commentVC : CommentViewController!
    var disMiss :Bool?
   var isLineUp :Bool?
    
    @IBOutlet var lblpenAway: UILabel!
    @IBOutlet var lblpenHome: UILabel!
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var imgStartus: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.adUnitID = ADMOBID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
      if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone)
      {
         if (UIScreen.main.bounds.height == 812)
         {
            ConstrianButtonPaddingTop.constant = 40
            constraintHeightDetail.constant = -88
         }
         //etc...
      }
      if objMatch.mStatus == "2" {
         self.initSwipeView1()
      }
      else{
         self.initSwipeView()
      }
      
      
        let userDefault = UserDefaults.standard
        if let statusRefresh = userDefault.string(forKey: String(format: "%@%@", KEY_SAVE_REFRESH_STATUS,GlobalEntities.leagueId)){
            if statusRefresh == "YES" {
                var time: Float = 1
                if let timeSaved: Float = userDefault.float(forKey: String(format: "%@%@", KEY_SAVE_TIME_REFRESH,GlobalEntities.leagueId)){
                    time = timeSaved
                }
                self.autoRefreshStart(Double(time*60))
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.showData()
        self.getDataFromServer()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        swipeableView.view.frame = self.viewTimeLineAndLineUp.frame
    }
    
    
    func showData(){
      
      
      
        lblNameTeam1.text = objMatch.mHomeName.localized.uppercased()
        lblNameTeam2.text = objMatch.mAwayName.localized.uppercased()
        lblGoalTeam1.text = objMatch.mHomeScore
        lblGoalTeam2.text = objMatch.mAwayScore
        lblStadium.text   = objMatch.mStadiumName
      if objMatch.mhomePen == "" && objMatch.mawayPen == "" {
         self.lblpenHome.isHidden = true
         self.lblpenAway.isHidden = true
      }
        lblpenHome.text = "(\(objMatch.mhomePen))"
        lblpenAway.text = "(\(objMatch.mawayPen))"
         lblGoalTeam1.text = objMatch.mHomeScore
         lblGoalTeam2.text = objMatch.mAwayScore
      
      if objMatch.mMinuteOver == "Postponed" || objMatch.mMinuteOver == "Cancelled" || objMatch.mMinuteOver == "Abandoned" {
        self.lblStatus.text = objMatch.mMinuteOver
         imgStartus.image = UIImage(named: "ic_gray")
         let date = Date(timeIntervalSince1970: Double(objMatch.mTime)!)
         let dateFormater = DateFormatter()
         dateFormater.dateFormat = "dd MMM"
         let strDate =  dateFormater.string(from: date)
         self.lblTimeStartMatch.text = strDate
         
      }else{
         if self.objMatch.mStatus == "0" {
            imgStartus.image = UIImage(named: "ic_gray")
            let date = Date(timeIntervalSince1970: Double(objMatch.mTime)!)
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd MMM"
            let strDate =  dateFormater.string(from: date)
            self.lblTimeStartMatch.text = strDate
            dateFormater.dateFormat = "HH:mm"
            let strHou = dateFormater.string(from: date)
            self.lblStatus.text = strHou
               lblGoalTeam1.text = "?"
               lblGoalTeam2.text = "?"
            
            
         }
         else if self.objMatch.mStatus == "1"{
            imgStartus.image = UIImage(named: "ic_green")
            let date = Date(timeIntervalSince1970: Double(objMatch.mTime)!)
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd MMM"
            let strDate =  dateFormater.string(from: date)
            self.lblTimeStartMatch.text = strDate
            self.lblStatus.text = "LIVE, \(self.objMatch.mMinuteOver)'"
            self.lblTimeStartMatch.textColor = UIColor.white
            self.lblStatus.textColor = UIColor.white
            
         }
            
         else{
            imgStartus.image = UIImage(named: "ic_gray")
            let date = Date(timeIntervalSince1970: Double(objMatch.mTime)!)
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd MMM"
            let strDate =  dateFormater.string(from: date)
            self.lblTimeStartMatch.text = strDate
            self.lblStatus.text = "FINISH"
         }
      }
        
      
            

 
    }
    
    func getDataFromServer(){
        APIManager.getMatchDetail(objMatch.mId){ (isSuccess, message, objMatch) in
            switch isSuccess{
            case false:
                break
            case true:
                DispatchQueue.main.async(execute: {
                    self.objMatch = objMatch
                    self.showData()
                })
                break
            }}
        
    }
    
    func autoRefreshStart(_ time: Double){
        Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(DetailMatchController.viewWillAppear(_:)), userInfo: nil, repeats: true)
    }
    
    @IBOutlet weak var lblStadium: UILabel!
 
    @IBOutlet weak var lblTimeStartMatch: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblGoalTeam2: UILabel!
    @IBOutlet weak var lblGoalTeam1: UILabel!
    @IBOutlet weak var imgBackgroud: UIImageView!
   @IBOutlet weak var lblNameTeam1: MarqueeLabel!   
   @IBOutlet weak var lblNameTeam2: MarqueeLabel!
   @IBOutlet weak var viewTimeLineAndLineUp: UIView!
   
   @IBOutlet weak var ConstrianButtonPaddingTop: NSLayoutConstraint!
   
   @IBOutlet weak var constraintHeightDetail: NSLayoutConstraint!
   @IBAction func onRefresh(_ sender: AnyObject) {
        timeLineVC?.getDataFromServer()
        self.getDataFromServer()
    }
    
    @IBAction func onBack(_ sender: AnyObject) {
        if disMiss == true {
            self.dismiss(animated: false, completion: nil)
        }
        navigationController?.popViewController(animated: true)
    }
   
   
   func initSwipeView1(){
      isLineUp = false
      timeLineVC = storyboard?.instantiateViewController(withIdentifier: "TimeLineTableVCID") as? TimeLineTableVC
      timeLineVC.objMatch = self.objMatch
      commentVC = storyboard?.instantiateViewController(withIdentifier: "CommentViewController") as? CommentViewController
      commentVC.objMatch = self.objMatch
    swipeableView.segmentBarAttributes = [SMBackgroundColorAttribute : UIColor.lightGray]
    swipeableView.selectionBarAttributes = [SMBackgroundColorAttribute : UIColor.gray]
    swipeableView.buttonAttributes = [SMForegroundColorAttribute : UIColor.darkGray]
      swipeableView.titleBarDataSource = titleBarDataSource1
      swipeableView.buttonPadding = 0
      swipeableView.delegate = self
      swipeableView.buttonWidth = UIScreen.main.bounds.width / 2
      swipeableView.view.frame = self.viewTimeLineAndLineUp.frame
    swipeableView.buttonAttributes = [NSAttributedString.Key.font.rawValue: Util.defaultNormalFont()]
    self.addChild(swipeableView)
      self.view.addSubview(swipeableView.view)
    swipeableView.willMove(toParent: self)
      
   }
   
    
    func initSwipeView(){
       isLineUp = true
        lineUpVC = storyboard?.instantiateViewController(withIdentifier: "LineUpTreeTableViewControllerId") as? LineUpTreeTableViewController
        lineUpVC.objMatch = self.objMatch
        timeLineVC = storyboard?.instantiateViewController(withIdentifier: "TimeLineTableVCID") as? TimeLineTableVC
        timeLineVC.objMatch = self.objMatch
        commentVC = storyboard?.instantiateViewController(withIdentifier: "CommentViewController") as? CommentViewController
        commentVC.objMatch = self.objMatch
        swipeableView.segmentBarAttributes = [SMBackgroundColorAttribute : UIColor.lightGray]
        swipeableView.selectionBarAttributes = [SMBackgroundColorAttribute : UIColor.gray]
        swipeableView.buttonAttributes = [SMForegroundColorAttribute : UIColor.darkGray]
        swipeableView.titleBarDataSource = titleBarDataSource
        swipeableView.buttonPadding = 0
        swipeableView.delegate = self
        swipeableView.buttonWidth = UIScreen.main.bounds.width / 3
        swipeableView.view.frame = self.viewTimeLineAndLineUp.frame
        swipeableView.buttonAttributes = [NSAttributedString.Key.font.rawValue: Util.defaultNormalFont()]
        self.addChild(swipeableView)
        self.view.addSubview(swipeableView.view)
        swipeableView.willMove(toParent: self)
        
    }
    
    //MARK: - swipableTableView delegate
    func didLoadViewControllerAtIndex(_ index: Int) -> UIViewController {
      if isLineUp!{
        if index == 1 {
            return lineUpVC
        }else if index == 0{
            return timeLineVC
        }else{
             return commentVC
        }
      }else{
         if index == 0{
            return timeLineVC
         }else{
            return commentVC
      }
    }
   }
}
