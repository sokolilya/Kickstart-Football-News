//
//  DropDownTableController.swift
//  UEFAEuro
//
//  Created by HiCom on 4/5/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit
protocol DropDownTableVCDelegate: class {
    func didSelectedString(_ strSelected: TeamInSetting)
}

class DropDownTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbView: UITableView!

    @IBOutlet weak var lblTeam: UILabel!
    @IBOutlet weak var constraintWidth: NSLayoutConstraint!
    @IBOutlet weak var constraintLead: NSLayoutConstraint!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    weak var delegate:DropDownTableVCDelegate?
    var arrDropDown:[TeamInSetting]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.delegate = self
        tbView.dataSource = self
        let nib = UINib(nibName: "DropDownTableViewCell", bundle: nil)
        tbView.register(nib, forCellReuseIdentifier: "DropDownTableViewCell")
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDropDown.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell", for: indexPath) as! DropDownTableViewCell
        let objCountry = arrDropDown[indexPath.row]
        cell.lblNameCountry.text = objCountry.teamName
        cell.imgFlagCountry.kf.setImage(with: URL(string: objCountry.teamImage), placeholder: #imageLiteral(resourceName: "ic_unknown"), options: nil, progressBlock: nil, completionHandler: nil)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      delegate?.didSelectedString(arrDropDown[indexPath.row])
        removeAnimate()
    }
    

    func showInVC(_ aVC:UIViewController, animated:Bool){
        aVC.view.addSubview(self.view)
        aVC.addChild(self)
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
            }
        }) 
    }


}
