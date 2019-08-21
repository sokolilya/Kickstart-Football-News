//
//  TopScoreViewController.swift
//  UEFAEuro
//
//  Created by tuan vn on 4/2/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//
import GoogleMobileAds
import UIKit

class TopScoreViewController: UIViewController {
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(TopScoreViewController.getDataFromServer) , for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    @IBOutlet var viewSetting: UIView!
    @IBOutlet weak var lblNoTopScore: UILabel!

    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblPlayer: UILabel!
    @IBOutlet var bannerView: GADBannerView!
    
   

   
    @IBOutlet weak var tableView: UITableView!
    
    var topScores = [PlayerTopScoreObj]()
    
    struct TableViewCellIdentifier {
        static let topScoreCell = "topScoreCell"
        static let nothingCell = "nothingCell"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.adUnitID = ADMOBID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        lblScore.text = "kTopScoreScore".localized
        lblPlayer.text = "kTopScorePlayer".localized
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async { 
           self.getDataFromServer()
        }
        
    }
    
    @objc func getDataFromServer(){
        DispatchQueue.main.async { 
            self.lblNoTopScore.isHidden = true
        }
        APIManager.getListPlayerTopScore { (isSuccess, message, arrPlayer) in
            switch isSuccess{
            case false:
                DispatchQueue.main.async(execute: { 
                    self.refreshControl.endRefreshing()
                    self.view.makeToast(message: "Have some error while loading data".localized)
                })
                
                break
            case true:
                DispatchQueue.main.async(execute: {
                    self.refreshControl.endRefreshing()
                    self.topScores = arrPlayer
                    self.tableView.reloadData()
                    if self.topScores.count == 0 {
                        self.lblNoTopScore.isHidden = false
                    self.lblNoTopScore.text = "kNoTopScore".localized
                    }
                    
                })
                
                break
            }
        }
    
    }
}


extension TopScoreViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topScores.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if topScores.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.nothingCell, for: indexPath)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.topScoreCell, for: indexPath) as! TopScoreCell
            let top = topScores[indexPath.row]
            switch indexPath.row {
            case 0:
                cell.positionNo = 1
                break
            default:
//                if top.playerGoal == topScores[indexPath.row - 1].playerGoal {
                cell.positionNo = indexPath.row + 1
                break
            //    }
            }
            cell.configureCellForItem(top)
            return cell
        }
        
    }
}

extension TopScoreViewController: UITableViewDelegate{
    
    
}





