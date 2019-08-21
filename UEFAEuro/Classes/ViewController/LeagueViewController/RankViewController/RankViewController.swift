//
//  RankViewController.swift
//  WORLDCUP
//
//  Created by Trung Ngo on 7/17/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit
import GoogleMobileAds

class RankViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    var positionNo: Int!
    
    let util = Util()
    

    @IBOutlet var bannnerView: GADBannerView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
   @IBOutlet weak var tbView: UITableView!

    struct TableViewCellIdentifier {
        static let topScoreCell = "topScoreCell"
        static let nothingCell = "nothingCell"
    }
    
    var arrchampion = [rankChampionsleague]()
    var arrTeam = [TeamObj]()
    override func viewDidLoad() {
        super.viewDidLoad()
        bannnerView.adUnitID = ADMOBID
        bannnerView.rootViewController = self
        bannnerView.load(GADRequest())
        
        let nib = UINib(nibName: "CountryListCell", bundle: nil)
        tbView.register(nib, forCellReuseIdentifier: "CountryListCell")
        
        let nib2 = UINib(nibName: "GruopNameTableViewCell", bundle: nil)
        tbView.register(nib2, forCellReuseIdentifier: "GruopNameTableViewCell")
        

        self.indicatorView.startAnimating()
        if GlobalEntities.leaguetypeId == "2"{
            getdatachampion()
        }else{
            APIManager.getCurrentRoundWithLeague(GlobalEntities.leagueId) { (isSuccess, message, MatchObj) in
                switch isSuccess{
                case false:
                    self.indicatorView.stopAnimating()
                    self.indicatorView.isHidden = true
                    DispatchQueue.main.async(execute: {
                        self.view.makeToast(message: message)
                    });
                    GlobalEntities.currentRound = 0
                    break
                case true:
                    DispatchQueue.main.async(execute: {
                        GlobalEntities.currentRound = Int((MatchObj?.mRound)!)!
                    });
                    break
                }
            }
            getdata()
        }
    }
    func getdatachampion() {
        APIManager.getListPositionInChampion{ (isSuccess, message, arrListTeam) in
            switch isSuccess{
            case false:
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                DispatchQueue.main.async(execute: {
                    self.view.makeToast(message: message)
                });
                break
            case true:
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                DispatchQueue.main.async(execute: {
                    self.arrchampion = arrListTeam
                    self.tbView.reloadData()
                });
                break
            }
        }
    }
    func getdata(){
        APIManager.getListTeamPositionInLeague{ (isSuccess, message, arrListTeam) in
            switch isSuccess{
            case false:
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                DispatchQueue.main.async(execute: {
                    self.view.makeToast(message: message)
                });
                break
            case true:
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                DispatchQueue.main.async(execute: {
                    self.arrTeam = arrListTeam
                    self.tbView.reloadData()
                });
                break
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if GlobalEntities.leaguetypeId == "2" {
            return 40
        }else{
        return 0
   }
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if GlobalEntities.leaguetypeId == "2"{
            return arrchampion.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if GlobalEntities.leaguetypeId == "2" {
         let cell: GruopNameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GruopNameTableViewCell") as! GruopNameTableViewCell
        let gruop = arrchampion[section]
        cell.lblGruopName.text = gruop.groupName
        cell.backgroundColor = UIColor(red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha: 1.0)
            return cell
        }else{
            let cell1: CountryListCell = tableView.dequeueReusableCell(withIdentifier: "CountryListCell") as! CountryListCell
            return cell1
        }
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if GlobalEntities.leaguetypeId == "2"{
            let gruop = arrchampion[section]
            return gruop.groupArrClup.count
        }else{
            return arrTeam.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if GlobalEntities.leaguetypeId == "2" {
            let cell1: CountryListCell = tableView.dequeueReusableCell(withIdentifier: "CountryListCell", for: indexPath) as! CountryListCell
            let groupObj = arrchampion[indexPath.section]
            let team = groupObj.groupArrClup[indexPath.row]
            cell1.imgCountryName.text = team.TeamID
            cell1.lblRank.text = team.SttID
            cell1.lblPlayed.text = team.Played
            cell1.lblWin.text = team.WinID
            cell1.lblDraw.text = team.DrawID
            cell1.lblLost.text = team.LostID
            cell1.lblPoints.text = team.PtsID
            cell1.lblGoalDifference.text = team.GDID
            return cell1
        }
        else{
            let cell: CountryListCell = tableView.dequeueReusableCell(withIdentifier: "CountryListCell", for: indexPath) as! CountryListCell
            let team = self.arrTeam[indexPath.row]
            cell.imgCountryName.text = team.teamName
            let posittion = indexPath.row + 1
            cell.lblRank.text = "\(posittion)"
            cell.lblPlayed.text = team.teamPlayed
            cell.lblWin.text = team.teamWin
            cell.lblDraw.text = team.teamDraw
            cell.lblLost.text = team.teamLose
            cell.lblPoints.text = team.teamPoint
            cell.lblGoalDifference.text = team.teamGDiff
            if indexPath.row < 4 {
                cell.lblRank.textColor = Util.colorWithHexString("39A3DB")
                cell.lblRank.font = UIFont.boldSystemFont(ofSize: cell.lblRank.font.pointSize)
                cell.imgCountryName.textColor = UIColor(red: 114/255.0, green: 114/255.0, blue: 114/255.0, alpha: 1.0)
                cell.imgCountryName.font = UIFont.boldSystemFont(ofSize: cell.imgCountryName.font.pointSize)
                cell.lblPlayed.textColor = Util.colorWithHexString("39A3DB")
                cell.lblPlayed.font = UIFont.boldSystemFont(ofSize: cell.lblPlayed.font.pointSize)
                cell.lblWin.textColor = Util.colorWithHexString("39A3DB")
                cell.lblWin.font = UIFont.boldSystemFont(ofSize: cell.lblWin.font.pointSize)
                cell.lblDraw.textColor = Util.colorWithHexString("39A3DB")
                cell.lblDraw.font = UIFont.boldSystemFont(ofSize: cell.lblDraw.font.pointSize)
                cell.lblLost.textColor = Util.colorWithHexString("39A3DB")
                cell.lblLost.font = UIFont.boldSystemFont(ofSize: cell.lblLost.font.pointSize)
                cell.lblPoints.textColor = Util.colorWithHexString("39A3DB")
                cell.lblPoints.font = UIFont.boldSystemFont(ofSize: cell.lblPoints.font.pointSize)
                cell.lblGoalDifference.textColor = Util.colorWithHexString("39A3DB")
                cell.lblGoalDifference.font = UIFont.boldSystemFont(ofSize: cell.lblGoalDifference.font.pointSize)
            }else{
                cell.lblRank.textColor = UIColor(red: 114/255.0, green: 114/255.0, blue: 114/255.0, alpha: 1.0)
                cell.imgCountryName.textColor = UIColor(red: 114/255.0, green: 114/255.0, blue: 114/255.0, alpha: 1.0)
                cell.lblPlayed.textColor = UIColor(red: 114/255.0, green: 114/255.0, blue: 114/255.0, alpha: 1.0)
                cell.lblWin.textColor = UIColor(red: 114/255.0, green: 114/255.0, blue: 114/255.0, alpha: 1.0)
                cell.lblDraw.textColor = UIColor(red: 114/255.0, green: 114/255.0, blue: 114/255.0, alpha: 1.0)
                cell.lblLost.textColor = UIColor(red: 114/255.0, green: 114/255.0, blue: 114/255.0, alpha: 1.0)
                cell.lblPoints.textColor = UIColor(red: 114/255.0, green: 114/255.0, blue: 114/255.0, alpha: 1.0)
                cell.lblGoalDifference.textColor = UIColor(red: 114/255.0, green: 114/255.0, blue: 114/255.0, alpha: 1.0)
            }
            return cell
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

