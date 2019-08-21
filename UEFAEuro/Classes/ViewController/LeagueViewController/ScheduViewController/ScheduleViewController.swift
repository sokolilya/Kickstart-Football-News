//
//  ScheduleViewController.swift
//  WORLDCUP
//
//  Created by Trung Ngo on 7/17/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ScheduleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, DropRoundDelegate,DropTeamDelegate, MyCellDelegate ,AlarmDeleGate,Championsdelegate{
   
    
   
   
   
   
   @IBOutlet weak var btnTeam: UIButton!
   @IBOutlet weak var btnRound: UIButton!
    var arrChampion = [GroupObjTeam]()
   var arrWeek = [WeekObj]()

   var arrTeam = [TeamObj]()
   var arrMatch = [MatchObj]()
   
    @IBOutlet var btnGroup: UIButton!
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet weak var tbView: UITableView!
   @IBOutlet weak var indicatorView: UIActivityIndicatorView!


    @IBAction func btnonChooseGroup(_ sender: Any) {
        if GlobalEntities.leaguetypeId == "2" {
            let DropTeamVC: ChampionwithErroViewController = ChampionwithErroViewController(nibName: "ChampionwithErroViewController", bundle: nil)
            DropTeamVC.arrGroup = self.arrChampion
            DropTeamVC.delegate = self
            DropTeamVC.view.frame = UIScreen.main.bounds
            DropTeamVC.showInView(self.navigationController!, animated: true)
        }
    }
    
   @IBAction func onChooseTeam(_ sender: Any) {
    if GlobalEntities.leaguetypeId == "1" {
      let DropTeamVC: DropTeamViewController = DropTeamViewController(nibName: "DropTeamViewController", bundle: nil)
      DropTeamVC.arrTeam = self.arrTeam
      DropTeamVC.delegate = self
      DropTeamVC.view.frame = UIScreen.main.bounds
      DropTeamVC.showInView(self.navigationController!, animated: true)
    }
}
   
   @IBAction func onChooseRound(_ sender: Any) {
    if GlobalEntities.leaguetypeId == "1" {
        let DropRoundVC: DropRoundViewController = DropRoundViewController(nibName: "DropRoundViewController", bundle: nil)
        DropRoundVC.totalRound = arrTeam.count*2-2
        DropRoundVC.arrWeek = self.arrWeek
        DropRoundVC.view.frame = UIScreen.main.bounds
        DropRoundVC.delegate = self
        DropRoundVC.showInView(self.navigationController!, animated: true)
    }
}
   
   
   
   
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if GlobalEntities.leaguetypeId == "1" {
            btnRound.isHidden = false
            btnTeam.isHidden = false
            btnGroup.isHidden = true
        }else{
            btnRound.isHidden = true
            btnTeam.isHidden = true
            btnGroup.isHidden = false
        }
        bannerView.adUnitID = ADMOBID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        tbView.separatorStyle = UITableViewCell.SeparatorStyle.none
      let nib = UINib(nibName: "MatchCell", bundle: nil)
      tbView.register(nib, forCellReuseIdentifier: "MatchCell")
        btnTeam.setTitle("All", for: UIControl.State.normal)
      self.btnGroup.setTitle("All", for: .normal)
        btnRound.setTitle("Week \(GlobalEntities.currentRound)", for: UIControl.State.normal)
      if GlobalEntities.leaguetypeId == "1" {
         getClubArr()
         getWeekArr()
      }else{
         getGroupArr()
      }
      reloadData()
    }
   
   func getWeekArr() {
      indicatorView.startAnimating()
      APIManager.getListWeek{ (isSuccess, message, arrListTeam) in
         switch isSuccess{
         case false:
            DispatchQueue.main.async(execute: {
               self.indicatorView.stopAnimating()
               self.indicatorView.isHidden = true
               self.view.makeToast(message: message)
            });
            break
         case true:
            DispatchQueue.main.async(execute: {
               self.indicatorView.isHidden = true
               self.indicatorView.stopAnimating()
               self.arrWeek = arrListTeam
            });
            break
         }
      }
      
   }

   
   
   
   func reloadData(){
         APIManager.getListMatchByTeamWeekAndGruop(GlobalEntities.currentRoundSelected, GlobalEntities.currentGroupSelected, GlobalEntities.currentTeamSelected) { (isSucces, message, arrMatch) in
            switch isSucces{
            case false:
               DispatchQueue.main.async(execute: {
                  self.view.makeToast(message: message)
               });
               break
            case true:
               DispatchQueue.main.async(execute: {
                  self.arrMatch.removeAll()
                  self.arrMatch = arrMatch
                  self.tbView.reloadData()
               });
               break
            }
         }
         
      }
      
   
   
   func getGroupArr(){
      indicatorView.startAnimating()
      APIManager.getListChampionwithErro{ (isSuccess, message, arrListTeam) in
         switch isSuccess{
         case false:
            DispatchQueue.main.async(execute: {
               self.indicatorView.stopAnimating()
               self.indicatorView.isHidden = true
               self.view.makeToast(message: message)
            });
            break
         case true:
            DispatchQueue.main.async(execute: {
               self.indicatorView.isHidden = true
               self.indicatorView.stopAnimating()
               self.arrChampion = arrListTeam
            });
            break
         }
      }

   }

   
   
   func getClubArr(){
      indicatorView.startAnimating()
      APIManager.getListTeamPositionInLeague{ (isSuccess, message, arrListTeam) in
         switch isSuccess{
         case false:
            DispatchQueue.main.async(execute: {
               self.indicatorView.stopAnimating()
               self.indicatorView.isHidden = true
               self.view.makeToast(message: message)
            });
            break
         case true:
            DispatchQueue.main.async(execute: {
               self.indicatorView.isHidden = true
               self.indicatorView.stopAnimating()
               self.arrTeam = arrListTeam
            });
            break
         }
      }
   }
   
   func reloadAfterChooseRound(_ roundSelect: Int) {
      if roundSelect == 0{
         GlobalEntities.currentRoundSelected = ""
        self.btnRound.setTitle("All week", for: UIControl.State.normal)
         reloadData()
         if  GlobalEntities.currentTeamSelected == ""{
            self.btnRound.setTitle("Week \(GlobalEntities.currentRound)", for: UIControl.State.normal)
         }
      }else{
         let week = self.arrWeek[roundSelect - 1]
         GlobalEntities.currentRoundSelected = week.weekId
        self.btnRound.setTitle("\(week.weekName ?? "")", for: UIControl.State.normal)
         reloadData()
      }
   }
   
   func reloadAfterChooseTeam(_ teamName: String) {
      reloadData()
    self.btnTeam.setTitle(teamName, for: UIControl.State.normal)
      if GlobalEntities.currentTeamSelected == "" {
        self.btnTeam.setTitle("All", for: UIControl.State.normal)
      }
      if GlobalEntities.currentRoundSelected == ""{
        self.btnRound.setTitle("All Week", for: UIControl.State.normal)
      }
      if  GlobalEntities.currentRoundSelected == "" && GlobalEntities.currentTeamSelected == "" {
        self.btnTeam.setTitle("All", for: UIControl.State.normal)
        self.btnRound.setTitle("Week \(GlobalEntities.currentRound)", for: UIControl.State.normal)
      }
   }
    
    func reloadAfterChooseGruop(_ gruopID:String ,_ groupName:String){
        self.btnGroup.setTitle(" \(groupName ?? "")", for: UIControl.State.normal)
      GlobalEntities.currentGroupSelected = gruopID
      reloadData()
    }
    
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 110
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.arrMatch.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell: MatchCell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as! MatchCell
      let match = self.arrMatch[indexPath.row]
      cell.setDataForMatch(match)
      cell.backgroundColor = UIColor.clear
      cell.selectionStyle = .none
      cell.delegate = self
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let  detailMatchVC = self.storyboard!.instantiateViewController(withIdentifier: "DetailMatchControllerID") as!DetailMatchController
    let objMatch = arrMatch[indexPath.row]
      GlobalEntities.gmatchstatus = objMatch.mStatus
      GlobalEntities.homeName = objMatch.mHomeName
      GlobalEntities.awayName = objMatch.mAwayName
      GlobalEntities.penHome = objMatch.mhomePen
      GlobalEntities.penAway = objMatch.mawayPen
      detailMatchVC.objMatch = arrMatch[indexPath.row]
      self.navigationController?.pushViewController(detailMatchVC, animated: true)
   }
   
   func didTapButton(_ objMatch: MatchObj!) {
      let setAlarmVC: SetAlarmVC = SetAlarmVC(nibName: "SetAlarmVC", bundle: nil)
      setAlarmVC.objMatch = objMatch
      setAlarmVC.delegate = self
      setAlarmVC.view.frame = UIScreen.main.bounds
      setAlarmVC.showInView(self.navigationController!, animated: true)
   }
   func reloadAfterSave() {
      tbView.reloadData()
   }
   
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    

    

}
