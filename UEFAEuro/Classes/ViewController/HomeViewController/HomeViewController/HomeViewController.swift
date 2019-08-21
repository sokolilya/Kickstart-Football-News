//
//  HomeViewController.swift
//  UEFAEuro
//
//  Created by Nguyen Hieu on 3/19/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//
import GoogleMobileAds
import UIKit
import SMSwipeableTabView
import UserNotifications

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyCellDelegate,AlarmDeleGate, UNUserNotificationCenterDelegate {
    
    var arrALlMatch = [MatchByLeagueObj]()
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet var img_leag: UIImageView!
    @IBOutlet var lbl_leag: UILabel!
    
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var lblNoMatch: UILabel!
    @IBOutlet weak var constraintHeightNavi: NSLayoutConstraint!
    @IBOutlet weak var constraintPaddingTopView: NSLayoutConstraint!
    
    let datePicker = UIDatePicker()
    var pickerTime:Double = 0.0
    var checkChooseDate = false
    var showPicker: Bool = false
    
    @IBOutlet weak var pickView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        //    self.view.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone)
        {
            if (UIScreen.main.bounds.height == 812)
            {
                constraintHeightNavi.constant = 88
                constraintPaddingTopView.constant = 30
            }
        }
        tbView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let nib = UINib(nibName: "MatchCell", bundle: nil)
        tbView.register(nib, forCellReuseIdentifier: "MatchCell")
        let nib1 = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tbView.register(nib1, forCellReuseIdentifier: "HomeTableViewCell")
        datePicker.frame = pickView.frame
        datePicker.frame.size.width = UIScreen.main.bounds.size.width
        datePicker.backgroundColor = UIColor.white
        
        bannerView.adUnitID = ADMOBID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        lblHeader.text = "Home"
        showDatePicker()
        let timestamp = NSDate().timeIntervalSince1970
        pickerTime = TimeInterval(timestamp)
        getDefaultData()
    }
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    
    
    func getDefaultData(){
        self.indicatorView.isHidden = false
        self.indicatorView.startAnimating()
        APIManager.getListMatchByDefault(String(format:"%.0f",pickerTime)) { (issucces, message, arrMatch) in
            switch issucces{
            case false:
                self.indicatorView.isHidden = true
                self.view.makeToast(message: "Have some error while loading data".localized)
                self.datePicker.removeFromSuperview()
                break
            case true:
                self.indicatorView.isHidden = true
                DispatchQueue.main.async(execute: {
                    if arrMatch.count == 0{
                        self.lblNoMatch.text = "No match found"
                        self.tbView.isHidden = true
                        self.lblNoMatch.isHidden = false
                        self.datePicker.removeFromSuperview()
                        self.showPicker = false
                        
                        
                    }else{
                        self.arrALlMatch = arrMatch
                        self.tbView.reloadData()
                        
                        self.lblNoMatch.isHidden = true
                        self.tbView.isHidden = false
                        self.datePicker.removeFromSuperview()
                        self.showPicker = false
                        
                        
                    }
                });
            }
        }
    }
    
    
    
    
    func showDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    @IBAction func onReload(_ sender: Any) {
        if checkChooseDate{
            getdata()
        }
        else{
            getDefaultData()
        }
    }
    
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("\(day) \(month) \(year)")
            let dfmatter = DateFormatter()
            dfmatter.dateFormat="yyyy-MM-dd HH"
            let date = dfmatter.date(from:"\(year)-\(month)-\(day) 12")
            let dateStamp:TimeInterval = date!.timeIntervalSince1970
            pickerTime = Double(dateStamp)
            getdata()
        }
    }
    
    func getdata(){
        self.indicatorView.isHidden = false
        self.indicatorView.startAnimating()
        APIManager.getListMatchByDate(String(format:"%.0f",pickerTime)) { (issucces, message, arrMatch) in
            switch issucces{
            case false:
                self.indicatorView.isHidden = true
                self.view.makeToast(message: "Have some error while loading data".localized)
                self.datePicker.removeFromSuperview()
                self.showPicker = false
                
                
                break
            case true:
                self.indicatorView.isHidden = true
                DispatchQueue.main.async(execute: {
                    if arrMatch.count == 0{
                        self.lblNoMatch.text = "No match found"
                        self.tbView.isHidden = true
                        self.lblNoMatch.isHidden = false
                        self.datePicker.removeFromSuperview()
                        self.showPicker = false
                        
                        
                    }else{
                        self.arrALlMatch = arrMatch
                        self.tbView.reloadData()
                        self.lblNoMatch.isHidden = true
                        self.tbView.isHidden = false
                        self.datePicker.removeFromSuperview()
                        
                        self.showPicker = false
                        
                        
                    }
                });
            }
        }
    }
    
    //Mark TableView Delegate & DataSource
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        let objLeague = arrALlMatch[section]
        let leagueId = objLeague.leagueId
        
        for league in GlobalEntities.gLeague {
            if leagueId == league.leagueId{
                cell.lblName.text = league.leagueName.localizedUppercase
            }
        }
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return self.arrALlMatch.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let objMatchByLeague = arrALlMatch[section]
        let arrMatch = objMatchByLeague.arrMatch
        return (arrMatch?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MatchCell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as! MatchCell
        let objMatchByLeague = arrALlMatch[indexPath.section]
        let arrMatch = objMatchByLeague.arrMatch
        let objMatch = arrMatch![indexPath.row]
        cell.setDataForMatch(objMatch)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  detailMatchVC = self.storyboard!.instantiateViewController(withIdentifier: "DetailMatchControllerID") as!DetailMatchController
        let objMatchByLeague = arrALlMatch[indexPath.section]
        let arrMatch = objMatchByLeague.arrMatch
        let objMatch = arrMatch![indexPath.row]
        GlobalEntities.leaguetypeId = objMatch.mTypeId
        GlobalEntities.leagueId = objMatch.mLeagueId
        GlobalEntities.awayName = objMatch.mAwayName
        GlobalEntities.homeName = objMatch.mHomeName
        GlobalEntities.penHome = objMatch.mhomePen
        GlobalEntities.penAway = objMatch.mawayPen
        detailMatchVC.objMatch = arrMatch![indexPath.row]
        self.navigationController?.pushViewController(detailMatchVC, animated: true)
    }
    
    @IBAction func onChangeDate(_ sender: Any) {
        
        showPicker = !showPicker
        if showPicker {
            checkChooseDate = true
            self.view .addSubview(datePicker)
            
        }
        else{
            self.datePicker.removeFromSuperview()
            showPicker = false
            
        }
        
        
    }
    
    
    @IBAction func onMenu(_ sender: AnyObject) {
        self.slideMenuController()?.toggleLeft()
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
    
    
    
}




