//
//  DropTeamViewController.swift
//  WORLDCUP
//
//  Created by Trung Ngo on 7/21/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit


protocol DropTeamDelegate: AnyObject {
   func reloadAfterChooseTeam(_ teamName:String)
}

class DropTeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
   @IBOutlet weak var tbvTeam: UITableView!
   var arrTeam = [TeamObj]()
   var delegate:DropTeamDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
      let nib = UINib(nibName: "DropRoundTableViewCell", bundle: nil)
      tbvTeam.register(nib, forCellReuseIdentifier: "DropRoundTableViewCell")
      tbvTeam.delegate = self
      tbvTeam.dataSource = self
      tbvTeam.clipsToBounds = true
      tbvTeam.layer.cornerRadius = 4
      tbvTeam.layer.shadowColor = UIColor.black.cgColor
      tbvTeam.layer.shadowOffset =  CGSize(width: 4, height: 4)
      
    }
   
   
   @IBAction func onHide(_ sender: Any) {
      removeAnimate()
   }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
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
   
   //TableView DELEGATE && DATASOURCE
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 40
   }
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return arrTeam.count+1
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell: DropRoundTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DropRoundTableViewCell", for: indexPath) as! DropRoundTableViewCell
      if indexPath.row == 0 {
         cell.lblRound.text = "All"
      }
      else{
      let teamObj = arrTeam[indexPath.row-1]
      cell.lblRound.text = teamObj.teamName
      }
      return cell
         
   }
   
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
      if indexPath.row == 0 {
         GlobalEntities.currentTeamSelected = ""
         delegate?.reloadAfterChooseTeam("All")
      }
      else{
         let teamObj = arrTeam[indexPath.row-1]
         GlobalEntities.currentTeamSelected = teamObj.teamId
         delegate?.reloadAfterChooseTeam(teamObj.teamName)
      }
      removeAnimate()
   }
}
