//
//  LineUpTreeTableViewController.swift
//  UEFAEuro
//
//  Created by HiCom on 4/12/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit

class LineUpTreeTableViewController: UIViewController {
    var objMatch: MatchObj!
    var arrPlayerHome = [PlayerInMatchObj]()
    var arrPlayerAway = [PlayerInMatchObj]()
    
    @IBOutlet weak var lblNotUpdate: UILabel!
    @IBOutlet weak var lblStrikerAbb: UILabel!
    @IBOutlet weak var lblStriker: UILabel!
    @IBOutlet weak var lblMidfielderAbb: UILabel!
    @IBOutlet weak var lblMidfielder: UILabel!
    @IBOutlet weak var lblDefenderAbb: UILabel!
    @IBOutlet weak var lblDefender: UILabel!
    @IBOutlet weak var lblGoalKeeperAbb: UILabel!
    @IBOutlet weak var lblGoalKeeper: UILabel!
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet var lblHome: UILabel!
    @IBOutlet var lblAway: UILabel!
    
    @IBOutlet weak var lblClubAwayname: UILabel!
    @IBOutlet weak var lblClubHomeName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblHome.text = GlobalEntities.homeName
        lblAway.text = GlobalEntities.awayName
        lblStriker.text = "kStriker".localized
        lblStrikerAbb.text = "kStrikerAbb".localized
        lblMidfielder.text = "kMidfielder".localized
        lblMidfielderAbb.text = "kMidfielderAbb".localized
        self.lblNotUpdate.isHidden = true
        lblDefender.text = "kDefender".localized
        lblDefenderAbb.text = "kDefenderAbb".localized
        lblGoalKeeper.text = "kGoalkeeper".localized
        lblGoalKeeperAbb.text = "kGoalkeeperAbb".localized
        getDataFromServer()
    
        // Do any additional setup after loading the view.
    }
    

    func getDataFromServer(){
        
    APIManager.getListPlayerInLineUpOfMatch(objMatch.mId) { (isSuccess, message, arrPlayer) in
        switch isSuccess{
        case false:
         
            self.lblNotUpdate.isHidden = false
         
            break
        case true:
            self.arrPlayerAway.removeAll()
            self.arrPlayerHome.removeAll()
            for objPlayer in arrPlayer{
                if objPlayer.playerClupId == self.objMatch.mAwayId {
                self.arrPlayerAway.append(objPlayer)
                }else{
                self.arrPlayerHome.append(objPlayer)
                }
               
            }
            if self.arrPlayerAway.count == 0 && self.arrPlayerHome.count == 0{
               self.lblNotUpdate.isHidden = false
            }
            DispatchQueue.main.async(execute: {
                self.tbView.reloadData()
            })
            
            break
            
        }
        }
    
    }

}

extension LineUpTreeTableViewController: UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if arrPlayerAway.count == 0 || arrPlayerHome.count == 0 {
         return 0
      }else{
         if arrPlayerHome.count > arrPlayerAway.count{
            return arrPlayerAway.count
         }
         else if arrPlayerHome.count < arrPlayerAway.count{
            return arrPlayerHome.count
         }
         else{
            return arrPlayerHome.count
         }
      }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cell = tableView.dequeueReusableCell(withIdentifier: "LineUpCell") as? LineUpTreeTableViewCell
        if (cell == nil) {
            cell = LineUpTreeTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier:"LineUpCell")
        }
        let playerAway: PlayerInMatchObj = arrPlayerAway[indexPath.row]
        let playerHome = arrPlayerHome[indexPath.row]
        cell!.lblNameAwayPlayer?.text = playerAway.playerName
        cell!.lblTypeAwayPlayer?.text = playerAway.playerPositon.uppercased()
        cell!.lblNameHomePlayer?.text = playerHome.playerName
        cell!.lblTypeHomePlayer?.text = playerHome.playerPositon.uppercased()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
