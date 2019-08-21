//
//  DropRoundViewController.swift
//  WORLDCUP
//
//  Created by Trung Ngo on 7/21/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit


protocol DropRoundDelegate: AnyObject {
   func reloadAfterChooseRound(_ roundSelect: Int)
}

class DropRoundViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

   @IBOutlet weak var tbRoundView: UITableView!
   var totalRound : Int?
   var delegate: DropRoundDelegate?
   var arrWeek = [WeekObj]()
   
   override func viewDidLoad() {
        super.viewDidLoad()
      let nib = UINib(nibName: "DropRoundTableViewCell", bundle: nil)
      tbRoundView.register(nib, forCellReuseIdentifier: "DropRoundTableViewCell")
      tbRoundView.delegate = self
      tbRoundView.dataSource = self
      tbRoundView.clipsToBounds = true
      tbRoundView.layer.cornerRadius = 4
      tbRoundView.layer.shadowColor = UIColor.black.cgColor
      tbRoundView.layer.shadowOffset =  CGSize(width: 4, height: 4)
      
    }
   
   
   @IBAction func onHIde(_ sender: Any) {
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
   
   
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 30
   }
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.arrWeek.count + 1
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell: DropRoundTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DropRoundTableViewCell", for: indexPath) as! DropRoundTableViewCell
      cell.lblRound.textColor = UIColor.black

        if indexPath.row == 0{
            cell.lblRound.text = "All"
        }
        else{
            let week = self.arrWeek[indexPath.row - 1]
            cell.lblRound.text = week.weekName
         if week.currentWeek == "1"{
            cell.lblRound.textColor = Util.colorWithHexString("39A3DB")
         }else{
            cell.lblRound.textColor = UIColor.black
         }
        }
      return cell
}
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      delegate?.reloadAfterChooseRound(indexPath.row)
      removeAnimate()
   }
}
