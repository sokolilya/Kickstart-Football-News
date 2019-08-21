//
//  TimeLineTableVC.swift
//  UEFAEuro
//
//  Created by HiCom on 4/6/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit
enum EventType: String{
    case HomeGoal = "1"
    case RED = "2"
    case YELLOW = "3"
    case OwnGoal = "4"
    case Penalty = "5"
    case In = "6"
    case Out = "7"
}

enum Icon: String {
    case Goal = "football"
    case RED = "red_card"
    case YELLOW = "yellow_card"
    case OWNGOAL = "ic_own_goal"
    case PENALTY = "penalty"
    case IN_TEAM_A = "ic_in_teamA"
    case IN_TEAM_B = "ic_in_teamB"
    case OUT_TEAM_A = "ic_out_teamA"
    case OUT_TEAM_B = "ic_out_teamB"
}

class TimeLineTableVC: UITableViewController {
    @IBOutlet var lblMatch: UILabel!
    
    
    var objMatch: MatchObj!
    var arrEvent = [EventObj]()
    

    @IBOutlet var tbView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.delegate = self
        tbView.dataSource = self
        let nib = UINib(nibName: "informationcell", bundle: nil)
        tbView.register(nib, forCellReuseIdentifier: "informationcell")
    }

    override func viewWillAppear(_ animated: Bool) {
        self.getDataFromServer()
    }
    
    func getDataFromServer(){
        APIManager.getListEventOfMatch(objMatch.mId) { (isSuccess, message, arrEvent) in
            switch isSuccess{
        case false:
//            self.view.makeToast(message: "Have some error while loading data")
            break
        case true:
            self.arrEvent = arrEvent
            self.tbView.reloadData()
        }
        }
    }
    
    // MARK: - Table view data source
    

 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrEvent.count + 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if objMatch.mStatus == "0" {
         return tbView.bounds.size.height
      }else{
        return 40
      }
    }
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if objMatch.mStatus == "0" {
            let cel = tableView.dequeueReusableCell(withIdentifier: "informationcell", for: indexPath) as! informationcell
            cel.lblMatch.text = "Data not updated yet"
            
            return cel
        }else{
        if indexPath.row == arrEvent.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCellBasic")! as UITableViewCell
            cell.contentView.layer.masksToBounds = false
            return cell
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell") as? TimeLineTableVCCell
        if (cell == nil) {
            cell = TimeLineTableVCCell(style: UITableViewCell.CellStyle.default, reuseIdentifier:"TimeCell")
        }
        if indexPath.row == 0 {
            cell?.imgHiddenWhenCell01.isHidden = true
         }
        else{
         cell?.imgHiddenWhenCell01.isHidden = false
         }
         if indexPath.row == arrEvent.count - 1{
            cell?.imgHideBot.isHidden = true
         }
         else{
            cell?.imgHideBot.isHidden = false
         }
        let event = arrEvent[indexPath.row]
        if event.eventClupId == objMatch.mHomeId {
            cell?.lblNameEventTeamA.isHidden = false
            cell?.lblTimeEventTeamA.isHidden = false
            cell?.imgEventTeamA.isHidden = false
            cell?.lblNameEventTeamB.isHidden = true
            cell?.lblTimeEventTeamB.isHidden = true
            cell?.imgEventTeamB.isHidden = true
             cell?.lblNameEventTeamA.text = event.eventPlayer
            cell?.lblTimeEventTeamA.text = event.eventMinute + "'"
            
        }else{
            cell?.lblNameEventTeamB.isHidden = false
            cell?.lblTimeEventTeamB.isHidden = false
            cell?.imgEventTeamB.isHidden = false
            cell?.lblNameEventTeamA.isHidden = true
            cell?.lblTimeEventTeamA.isHidden = true
            cell?.imgEventTeamA.isHidden = true
            cell?.lblNameEventTeamB.text = event.eventPlayer
            cell?.lblTimeEventTeamB.text = event.eventMinute + "'"
        }
        
        switch event.eventType {
        case EventType.HomeGoal.rawValue:
            cell?.imgEventTeamA.image = UIImage(named: Icon.Goal.rawValue)
            cell?.imgEventTeamB.image = UIImage(named: Icon.Goal.rawValue)
            break
        case EventType.RED.rawValue:
            cell?.imgEventTeamA.image = UIImage(named: Icon.RED.rawValue)
            cell?.imgEventTeamB.image = UIImage(named: Icon.RED.rawValue)
            break
        case EventType.YELLOW.rawValue:
            cell?.imgEventTeamA.image = UIImage(named: Icon.YELLOW.rawValue)
            cell?.imgEventTeamB.image = UIImage(named: Icon.YELLOW.rawValue)
            break
        case EventType.OwnGoal.rawValue:
            cell?.imgEventTeamA.image = UIImage(named: Icon.OWNGOAL.rawValue)
            cell?.imgEventTeamB.image = UIImage(named: Icon.OWNGOAL.rawValue)
            break
        case EventType.Penalty.rawValue:
            cell?.imgEventTeamA.image = UIImage(named: Icon.PENALTY.rawValue)
            cell?.imgEventTeamB.image = UIImage(named: Icon.PENALTY.rawValue)
            break
        case EventType.In.rawValue:
            cell?.imgEventTeamA.image = UIImage(named: Icon.IN_TEAM_A.rawValue)
            cell?.imgEventTeamB.image = UIImage(named: Icon.IN_TEAM_B.rawValue)
            break
        case EventType.Out.rawValue:
            cell?.imgEventTeamA.image = UIImage(named: Icon.OUT_TEAM_A.rawValue)
            cell?.imgEventTeamB.image = UIImage(named: Icon.OUT_TEAM_B.rawValue)
            break
        default: break
            
        }
        
       
        

        // Configure the cell...

        return cell!
        }
    }
}
