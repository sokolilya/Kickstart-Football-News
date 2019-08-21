//
//  ChampionwithErroViewController.swift
//  WORLDCUP
//
//  Created by HiCom on 8/8/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit
protocol Championsdelegate: AnyObject {
    func reloadAfterChooseGruop(_ gruopID:String ,_ groupName:String)
}


class ChampionwithErroViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource {
    var arrGroup = [GroupObjTeam]()
    var delegate:Championsdelegate?
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGroup.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: championwithErroCell = tableView.dequeueReusableCell(withIdentifier: "championwithErroCell", for: indexPath) as! championwithErroCell
      if indexPath.row == 0{
         cell.lblGroup.text = "All"
      }else{
         let team = arrGroup[indexPath.row - 1]
         cell.lblGroup.text = team.groupName
      }
        return cell
    }
    func showInView(_ aView:UIViewController, animated:Bool){
        aView.view.addSubview(self.view)
        aView.addChild(self)
        if animated == true{
            self.showAnimate()
        }
    }
    func showAnimate(){
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0;
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.view.alpha = 1;
            self.view.transform = CGAffineTransform(scaleX: 1, y: 1);
        })
    }
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0;
        }, completion: { (finished) -> Void in
            if finished == true{
                self.view.removeFromSuperview()
                self.navigationController?.popViewController(animated: false)
            }
        })
    }
    @IBOutlet var tbViewShowTeam: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbViewShowTeam.dataSource = self
        self.tbViewShowTeam.delegate = self
        let nib = UINib(nibName: "championwithErroCell", bundle: nil)
        tbViewShowTeam.register(nib, forCellReuseIdentifier: "championwithErroCell")
    }
   
   @IBAction func onHide(_ sender: Any) {
      removeAnimate()
   }
   
   
    func getdata(){
        APIManager.getListChampionwithErro{ (isSuccess, message, arrListTeam) in
            switch isSuccess{
            case false:
                DispatchQueue.main.async(execute: {
                    self.view.makeToast(message: message)
                });
                break
            case true:
                DispatchQueue.main.async(execute: {
                    self.arrGroup = arrListTeam
                    self.tbViewShowTeam.reloadData()
                });
                break
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if indexPath.row == 0 {
         delegate?.reloadAfterChooseGruop("", "All")
      }else{
         let objGruop = self.arrGroup[indexPath.row - 1]
         delegate?.reloadAfterChooseGruop(objGruop.gruopId, objGruop.groupName)
      }
        removeAnimate()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

