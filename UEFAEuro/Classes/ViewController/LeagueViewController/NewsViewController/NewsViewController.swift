//
//  NewsViewController.swift
//  UEFAEuro
//
//  Created by tuan vn on 4/2/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//
import GoogleMobileAds
import UIKit

class NewsViewController: UIViewController, XMLParserDelegate {
    // xml parser
    var myParser: XMLParser = XMLParser()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(NewsViewController.loadRSSData) , for: UIControl.Event.valueChanged)
        
        return refreshControl
    }()
    var arrNew = [RssRecord]()
    

    
    @IBOutlet var lblposttime: UILabel!
    
    @IBOutlet weak var bannerView: GADBannerView!
    // rss records

 
    var rssRecord : RssRecord?
    var isTagFound = [ "item": false , "title": false,"description": false, "pubDate": false ,"link": false ,"enclosure": false]


   @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.adUnitID = ADMOBID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
      
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        navigationController?.isNavigationBarHidden = true
        self.tableView.addSubview(refreshControl)
        loadRSSData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.refreshControl.beginRefreshing()
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async { 
            if(gArrRssObj.count == 0){
                self.loadRSSData()
            }else{
                self.refreshControl.endRefreshing()
            }
        }
    }

    


    @objc func loadRSSData(){
        if URL_RSS == "" {
            APIManager.getRssUrl { (isSuccess, message, strUrl) in
                switch isSuccess{
                case false:
                    self.refreshControl.endRefreshing()
                    
                    break
                case true:
                    URL_RSS = strUrl
                    gArrImgRss .removeAll()
                    gArrRssObj.removeAll()
//                    self.arrNew.removeAll()
                    if let rssURL = URL(string: URL_RSS) {
                        // fetch rss content from url
                        self.myParser = XMLParser(contentsOf: rssURL)!
                        // set parser delegate
                        self.myParser.delegate = self
                        self.myParser.shouldResolveExternalEntities = false
                        // start parsing
                        self.myParser.parse()
                    }
                    self.refreshControl.endRefreshing()

                 //   })
                    break
                }
            }
        }else{
            gArrRssObj.removeAll()
            gArrImgRss.removeAll()
            if let rssURL = URL(string: URL_RSS) {
                // fetch rss content from url
                self.myParser = XMLParser(contentsOf: rssURL)!
                // set parser delegate
                self.myParser.delegate = self
                self.myParser.shouldResolveExternalEntities = false
                // start parsing
                self.myParser.parse()
//                arrNew.removeAll()
            }
            tableView.reloadData()
        self.refreshControl.endRefreshing()
        }
        
    }
    
    // MARK: - NSXML Parse delegate function
    
    // start parsing document
    func parserDidStartDocument(_ parser: XMLParser) {
        // start parsing
    }
    
    // element start detected
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == "item" {
            self.isTagFound["item"] = true
            self.rssRecord = RssRecord()
            
        }else if elementName == "title" {
            self.isTagFound["title"] = true
            
        }else if elementName == "link" {
            self.isTagFound["link"] = true
            
        }else if elementName == "pubDate" {
            self.isTagFound["pubDate"] = true
            
        }else if elementName == "enclosure"{
            let imgLink = attributeDict["url"]! as String
            gArrImgRss.append(imgLink)
            self.isTagFound["enclosure"] = true
        }else if elementName == "description"{
            self.isTagFound["description"] = true
        }
        
    }
    
    // characters received for some element
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if isTagFound["title"] == true {
            self.rssRecord?.title += string
            
        }else if isTagFound["link"] == true {
            self.rssRecord?.link += string
            
        }else if isTagFound["pubDate"] == true {
            self.rssRecord?.pubDate += string
            
        }else if isTagFound["enclosure"] == true {
            self.rssRecord?.enclosure += string
            
        }else if isTagFound["description"] == true {
            self.rssRecord?.description += string
        }
    }
    
    // element end detected
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            self.isTagFound["item"] = false
            gArrRssObj.append(self.rssRecord!)
            
        }else if elementName == "title" {
            self.isTagFound["title"] = false
            
        }else if elementName == "link" {
            self.isTagFound["link"] = false
            
        }else if elementName == "pubDate" {
            self.isTagFound["pubDate"] = false
            
        }else if elementName == "enclosure" {
            self.isTagFound["enclosure"] = false
            
        }else if elementName == "description" {
            self.isTagFound["description"] = false
        }
    }
    
    // end parsing document
    func parserDidEndDocument(_ parser: XMLParser) {
        
        //reload table view
        self.tableView.reloadData()

    }
    
    // if any error detected while parsing.
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {

        
        // show error message
        self.showAlertMessage(alertTitle: "Error", alertMessage: "Error while parsing xml.")
    }
    
    
    fileprivate func showAlertMessage(alertTitle: String, alertMessage: String ) -> Void {
        
        // create alert controller
        let alertCtrl = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert) as UIAlertController
        
        // create action
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:
            { (action: UIAlertAction) -> Void in
                // you can add code here if needed
        })
        
        // add ok action
        alertCtrl.addAction(okAction)
        
        self.present(alertCtrl, animated: true) {
            
        }
        // present alert
//        self.present(alertCtrl, animated: true, completion: { (void) -> Void in
            // you can add code here if needed
//        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let selectedPatch : IndexPath = self.tableView.indexPathForSelectedRow!
            let destVC = segue.destination as! DetailNewViewController
            destVC.urlPage = gArrRssObj[selectedPatch.row].link
        }
    }
    
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gArrRssObj.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        cell.configCell(gArrRssObj[indexPath.row], imgUrl: gArrImgRss[indexPath.row])
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "detail", sender: nil)
       UIApplication.shared.openURL(URL(string: gArrRssObj[indexPath.row].link)!)
    }
    
}



