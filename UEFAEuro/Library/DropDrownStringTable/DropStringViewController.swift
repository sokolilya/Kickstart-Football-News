//
//  DropStringViewController.swift
//  Euro2016
//
//  Created by Ngọc Toán on 2/13/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit
protocol DropStringVCDelegate: class {
    func didSelectedStringBonus(_ strSelected: String)
}
class DropStringViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbView: UITableView!
    
    @IBOutlet weak var lblTeam: UILabel!
    @IBOutlet weak var constraintWidth: NSLayoutConstraint!
    @IBOutlet weak var constraintLead: NSLayoutConstraint!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    weak var delegate:DropStringVCDelegate?
    var arrDropDown:[String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constraintHeight.constant = UIScreen.main.bounds.height/3*2
        let height = 44*arrDropDown.count
        if CGFloat(height) > constraintHeight.constant {
            
        }else{
            constraintHeight.constant = CGFloat(height)
        }
        tbView.delegate = self
        tbView.dataSource = self
        let nib = UINib(nibName: "DropStringTableViewCell", bundle: nil)
        tbView.register(nib, forCellReuseIdentifier: "DropStringTableViewCell")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDropDown.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "DropStringTableViewCell", for: indexPath) as! DropStringTableViewCell
        cell.lblTitle.text = arrDropDown[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectedStringBonus(arrDropDown[indexPath.row])
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
