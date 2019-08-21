//
//  DetailNewViewController.swift
//  UEFAEuro
//
//  Created by tuan vn on 4/2/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit

class DetailNewViewController: UIViewController {
    var urlPage = "www.google.com"

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var webView: UIWebView!
   
   @IBOutlet weak var ConStrianNavigationViewHiegh: NSLayoutConstraint!
   
   @IBOutlet weak var ConstrianButtonTopPadding: NSLayoutConstraint!
   override func viewDidLoad() {
        super.viewDidLoad()
    lblTitle.text = "kDetailNew".localized
      if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone)
      {
         if (UIScreen.main.bounds.height == 812)
         {
            ConstrianButtonTopPadding.constant = 40
            ConStrianNavigationViewHiegh.constant = 88
         }
         //etc...
      }
        webView.loadRequest(URLRequest(url: URL(string: urlPage)!))
        
        
    }

    @IBAction func actionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
  
    
}

extension DetailNewViewController : UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
    
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
     
    }
}
