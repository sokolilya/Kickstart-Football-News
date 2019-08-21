//
//  DropRoundViewController.swift
//  WORLDCUP
//
//  Created by Trung Ngo on 7/21/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit

class DropRoundViewController: UIViewController {

   
    var totalRound : Int?
   
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
   
   

   func showInView(_ aView:UIViewController, animated:Bool){
      aView.view.addSubview(self.view)
      aView.addChildViewController(self)
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
   
   
   
   

}
