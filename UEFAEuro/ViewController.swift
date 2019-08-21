//
//  ViewController.swift
//  UEFAEuro
//
//  Created by hieu nguyen on 3/7/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit
import UserNotifications


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UNUserNotificationCenterDelegate{

   var arrLeague = [LeagueObj]()
    @IBOutlet weak var tblView: UITableView!
   

   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let nib = UINib(nibName: "MenuCell", bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: "MenuCell")
        let footerView =  UIView(frame: CGRect.zero)
        tblView.tableFooterView = footerView
        tblView.tableFooterView!.isHidden = true
         getListMatch()
      
    }
   @available(iOS 10.0, *)
   func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      completionHandler([.alert, .badge, .sound])
   }
   
   func getListMatch(){
      APIManager.getListLeague{ (isSuccess, message, arrMatch) in
         switch isSuccess{
         case false:
            DispatchQueue.main.async(execute: {
               self.view.makeToast(message: message)
            });
            break
         case true:
            DispatchQueue.main.async(execute: {
               self.arrLeague = arrMatch
               GlobalEntities.gLeague = arrMatch
               self.tblView.reloadData()
            });
            
            break
         }
         
      }
      
   }
   
    //MARK: UITableviewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLeague.count+1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuCell = tblView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
      if indexPath.row == 0 {
         cell.lblMenuName.text = "Home"
        cell.icMenu.image = UIImage.init(named: "close-matches.png")
      }
      else{
         let objLeague = arrLeague[indexPath.row-1] as LeagueObj
         cell.icMenu.kf.setImage(with: URL(string: objLeague.leagueImage), placeholder: #imageLiteral(resourceName: "ic_unknown"), options: nil, progressBlock: nil, completionHandler: nil)
         cell.lblMenuName.text = objLeague.leagueName
      }
        return cell
    }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let sb = UIStoryboard(name: "Main", bundle: nil)
      if indexPath.row==0 {
         let controller = sb.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController;
         self.slideMenuController()?.changeMainViewController(controller, close: true)
      }
      else{
         if GlobalEntities.isDemo == "0"{
            let objLeague = arrLeague[indexPath.row-1] as LeagueObj
            GlobalEntities.leaguetypeId = objLeague.leagueTypeId
            GlobalEntities.leagueId = objLeague.leagueId
            GlobalEntities.leagueName = objLeague.leagueName
            GlobalEntities.currentTeamSelected = ""
            GlobalEntities.currentGroupSelected = ""
            GlobalEntities.currentRoundSelected = ""
            URL_RSS = ""
            let controller = sb.instantiateViewController(withIdentifier: "LeagueViewController") as! LeagueViewController;
            self.slideMenuController()?.changeMainViewController(controller, close: true)
         }
         else{
            if indexPath.row == 1 || indexPath.row == 2{
               let objLeague = arrLeague[indexPath.row-1] as LeagueObj
               GlobalEntities.leaguetypeId = objLeague.leagueTypeId
               GlobalEntities.leagueId = objLeague.leagueId
               GlobalEntities.leagueName = objLeague.leagueName
               GlobalEntities.currentTeamSelected = "0"
               GlobalEntities.currentRoundSelected = ""
               URL_RSS = ""
               let controller = sb.instantiateViewController(withIdentifier: "LeagueViewController") as! LeagueViewController;
               self.slideMenuController()?.changeMainViewController(controller, close: true)
            }
            else{
                let alert = UIAlertController(title:"kAppName".localized, message: "This league is currently locked because you are using the DEMO version. Only the first 2 leagues: English Championship  & French Ligue 2 are active. Buy our source code and apifootball data feed key today to unlock all leagues" , preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
               self.present(alert, animated: true, completion: nil)
            }
         }
         
      }
   }
   

}



