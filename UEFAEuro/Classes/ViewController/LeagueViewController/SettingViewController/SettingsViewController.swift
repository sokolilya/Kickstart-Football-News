//
//  SettingsViewController.swift
//  UEFAEuro
//
//  Created by tuan vn on 4/2/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//
import GoogleMobileAds
import UIKit

class SettingsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

   @IBOutlet var imUp: UIImageView!
   @IBOutlet var imgDown: UIImageView!
   @IBOutlet weak var lblAll: UILabel!
   @IBOutlet weak var lblTurnOnAlert: UILabel!
   @IBOutlet weak var lblOnOffNoti: UILabel!
   @IBOutlet weak var lblAutoRefresh: UILabel!
   @IBOutlet weak var imgAutoRefresh: UIImageView!
   @IBOutlet weak var constraintNotiButtonToTop: NSLayoutConstraint!
   @IBOutlet weak var btnAutoRefresh: UIButton!
   @IBOutlet weak var slider: UISlider!
   @IBOutlet weak var viewSlider: UIView!
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var notifyCheckImage: UIImageView!
   @IBOutlet weak var checkAllImage: UIImageView!
   @IBOutlet weak var selectTeamView: UIView!
    @IBOutlet var bannerView: GADBannerView!
    
   var notifyOn = false
   var alertOn = false
   var checkAllTeam = false
    var ShowTeam = false
    
    
   
   @IBAction func onAutoRefresh(_ sender: AnyObject) {
      self.btnAutoRefresh.isSelected = !self.btnAutoRefresh.isSelected
      if btnAutoRefresh.isSelected == true {
         imgAutoRefresh.image = UIImage(named: "setting_checked")
         constraintNotiButtonToTop.constant = CGFloat(60)
         self.viewSlider.isHidden = false
         Util.setObject("YES" as NSObject, forKey: (String(format: "%@%@", KEY_SAVE_REFRESH_STATUS,GlobalEntities.leagueId)))
      }else{
         imgAutoRefresh.image = UIImage(named: "setting_unchecked")
         self.viewSlider.isHidden = true
         constraintNotiButtonToTop.constant = CGFloat(10)
         Util.setObject("NO" as NSObject, forKey: (String(format: "%@%@", KEY_SAVE_REFRESH_STATUS,GlobalEntities.leagueId)))
      }
   }
   
   
    @IBOutlet var btnAlert: UIButton!
    @IBAction func touchAlert(_ sender: AnyObject) {
        ShowTeam = !ShowTeam
        if ShowTeam {
            self.selectTeamView.isHidden = false
            imUp.isHidden = false
            imgDown.isHidden = true
        }else{
            self.selectTeamView.isHidden = true
            imgDown.isHidden = false
            imUp.isHidden = true
        }
      
   }
   
   @IBAction func touchNotification(_ sender: AnyObject) {
      notifyOn = !notifyOn
      if notifyOn {
         notifyCheckImage.image = UIImage(named: "setting_checked")
      }else{
         notifyCheckImage.image = UIImage(named: "setting_unchecked")
      }
   }
   
   
   @IBAction func touchAll(_ sender: AnyObject) {
      checkAllTeam = !checkAllTeam
      if checkAllTeam {
         checkAllImage.image = UIImage(named: "setting_checked")
         for obj in GlobalEntities.gArrTeamInSetting {
            obj.teamSelected = true
         }
      }else{
         checkAllImage.image = UIImage(named: "setting_unchecked")
         for obj in GlobalEntities.gArrTeamInSetting {
            obj.teamSelected = false
         }
      }
      tableView.reloadData()
   }
   
   
   func configureCheckBox(_ imageChecked: UIImageView, checked: Bool){
      if checked {
         imageChecked.image = UIImage(named: "setting_checked")
      }else{
         imageChecked.image = UIImage(named: "setting_unchecked")
      }
   }
   
   func updateView(){
      configureCheckBox(notifyCheckImage, checked: notifyOn)
      configureCheckBox(checkAllImage, checked: checkAllTeam)
      
   }
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.adUnitID = ADMOBID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        imUp.isHidden = true
      let userDefault = UserDefaults.standard
      if let timeRefreshStatus = userDefault.string(forKey: String(format: "%@%@", KEY_CHECK_NOTI,GlobalEntities.leagueId)){
         if timeRefreshStatus == "YES" {
            self.notifyOn = true
         }
      }else{
            self.notifyOn = false
      }
         self.tableView.dataSource = self
         self.tableView.delegate = self
         self.getDataFromServer()
      
    }
 
   
   override func viewWillAppear(_ animated: Bool) {
      if GlobalEntities.gStatus == "1" {
         //  self.notifyOn = true
         selectTeamView.isHidden = false
         notifyCheckImage.image = UIImage(named: "setting_checked")
      }
      let userDefault = UserDefaults.standard
      if let timeRefreshStatus = userDefault.string(forKey: (String(format: "%@%@", KEY_SAVE_REFRESH_STATUS,GlobalEntities.leagueId))){
         if timeRefreshStatus == "YES" {
            imgAutoRefresh.image = UIImage(named: "setting_checked")
            self.btnAutoRefresh.isSelected = true
             self.viewSlider.isHidden = false
            if  let valureSlider: Float? = userDefault.float(forKey: (String(format: "%@%@", KEY_SAVE_TIME_REFRESH,GlobalEntities.leagueId))) {
               slider.value = valureSlider!
               
            }
         }else{
            self.btnAutoRefresh.isSelected = false
            self.viewSlider.isHidden = true
            constraintNotiButtonToTop.constant = CGFloat(10)
         }
      }else{
         self.viewSlider.isHidden = true
         self.btnAutoRefresh.isSelected = false
         constraintNotiButtonToTop.constant = CGFloat(10)
      }
      if notifyOn {
         notifyCheckImage.image = UIImage(named: "setting_checked")
      }else{
         notifyCheckImage.image = UIImage(named: "setting_unchecked")
      }
   }
   
   func getDataFromServer(){
    if GlobalEntities.leaguetypeId == "1" {
        APIManager.showCountryInSetting { (isSuccess, message, arrCountry) in
            switch isSuccess{
            case false:
                self.view.makeToast(message: "Have some error while loading data".localized)
                break
            case true:
                GlobalEntities.gArrTeamInSetting = arrCountry
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                break
                
            }
        }
    }
        
    else{
        APIManager.showTeamInSetting { (isSuccess, message, arrCountry) in
            switch isSuccess{
            case false:
                self.view.makeToast(message: "Have some error while loading data".localized)
                break
            case true:
                GlobalEntities.gArrTeamInSetting = arrCountry
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                break
                
            }
        }
   }
}
   
   
      
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalEntities.gArrTeamInSetting.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsCell
        let team = GlobalEntities.gArrTeamInSetting[indexPath.row]
        cell.configureForCell(team)
    return cell
}
   
   func saveSetting() {
      if btnAutoRefresh.isSelected == true {
         let defaults = UserDefaults.standard
         defaults.set("YES", forKey: (String(format: "%@%@", KEY_SAVE_REFRESH_STATUS,GlobalEntities.leagueId)))
         defaults.set(slider.value, forKey: (String(format: "%@%@", KEY_SAVE_TIME_REFRESH,GlobalEntities.leagueId)))
         
         
      }else{
         let defaults = UserDefaults.standard
         defaults.set("NO", forKey: (String(format: "%@%@", KEY_SAVE_REFRESH_STATUS,GlobalEntities.leagueId)))
         
      }
    
      
      var strCLubIds = ","
      var strCheck = ","
      for obj in GlobalEntities.gArrTeamInSetting{
         if (obj.teamSelected) {
            if strCLubIds == "," {
               strCLubIds = obj.teamId
            }else{
               strCLubIds = strCLubIds + "," + obj.teamId
            }
         }
         else{
            if strCheck == "," {
               strCheck = obj.teamId
            }else{
               strCheck = strCheck + "," + obj.teamId
            }
         }
      }
      strCLubIds = strCLubIds + ","
      
      if self.notifyOn {
          let userDefault = UserDefaults.standard
          userDefault.set("YES", forKey: String(format: "%@%@", KEY_CHECK_NOTI,GlobalEntities.leagueId))
         GlobalEntities.gStatus = "1"
      }else{
         let userDefault = UserDefaults.standard
         userDefault.set("NO", forKey: String(format: "%@%@", KEY_CHECK_NOTI,GlobalEntities.leagueId))
         GlobalEntities.gStatus = "0"
      }
      APIManager.updateDeviceSetting(GlobalEntities.gIME, status: GlobalEntities.gStatus, clubId: strCLubIds) { (isSuccess, message) in
         switch isSuccess{
         case false:
//            self.view.makeToast(message: "Update failed")
            self.view.makeToast(message: "Update failed", duration: 1, position: HRToastPositionCenter as AnyObject)
            break
         case true:
            let userDefault = UserDefaults.standard
               userDefault.set(strCLubIds, forKey: String(format: "%@%@", KEY_SAVE_SETTING,GlobalEntities.leagueId))
            self.view.makeToast(message: "Update Successful", duration: 1, position: HRToastPositionCenter as AnyObject)
         }
      }

      
   }
   
   
   
   
    
}
