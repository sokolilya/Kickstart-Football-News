//
//  AppDelegate.swift
//  UEFAEuro
//
//  Created by hieu nguyen on 3/7/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//

import UIKit
import CoreData
import SlideMenuControllerSwift
import UserNotifications
import Firebase
import GoogleMobileAds
import KYDrawerController



struct GlobalEntities {
    static var gArrTeamSelected = Array<String>()
    static var gStatus = "0"
    static var isDemo = "0"
    static var gmatchstatus = "0"
    static var leagueId: String = "0"
    static var leaguetypeId: String = "0"
    static var currentRound: Int = 0
    static var currentChampion: Int = 0
    static var gArrReminder = Array<String>()
    static var currentTeamSelected: String = ""
    static var currentGroupSelected: String = ""
    static var currentRoundSelected: String = ""
    static var leagueName: String = "0"
    static var homeName : String = "0"
    static var awayName : String = "0"
    static var penHome : String = "0"
    static var penAway :String = "0"
    static var deviceToken: String {
        get {
            return UserDefaults.standard.object(forKey: "DeviceToke") as! String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "DeviceToke")
            UserDefaults.standard.synchronize()
        }
    }
    static let gColorTextPlaying = UIColor.blue
    static let gColorTextWillPlay = UIColor.darkGray
    static var gDicTeamNameFlag: [String : String] = [:]
    static var gArrTeamInSetting = [TeamInSetting]()
    static var gArrGroupChampion = [GroupObj]()
    
    
    static var gLeague = [LeagueObj]()
    static var groupArrClup: [objGroupTeam]!
    static var gIME = ""
    static var gRssUrl = "http://www.skysports.com/rss/0,20514,11661,00.xml"
    
}
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, XMLParserDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UserDefaults.standard.set("pt-PT", forKey: KEY_SAVE_LANGUAGE)
        FirebaseApp.configure()
        UIApplication.shared.statusBarStyle = .lightContent
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController")
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        
        let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: menuViewController)
        
        let naviVC = UINavigationController(rootViewController: slideMenuController)
        naviVC.isNavigationBarHidden = true
        self.window?.rootViewController = naviVC
        self.window?.makeKeyAndVisible()
        registerNotification(application)
        

        //GADMobileAds.configure(withApplicationID: "ca-app-pub-3940256099942544~1458002511")
        GADMobileAds.configure(withApplicationID: "ca-app-pub-6909172246232011~8014946618")
        
        //        if let notification = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? NSDictionary{
        //        self.gotoDetailMatchVCFromPush((notification["aps"] as? Dictionary<String, AnyObject>)! as NSDictionary)
        //
        //        }
        
        return true
    }
    
    
    func registerNotification(_ application: UIApplication) {
        
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 7 support
        else {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
    }
    func registerForPushNotifications(_ application: UIApplication) {
        let notificationSettings = UIUserNotificationSettings(
            types: [.badge, .sound, .alert], categories: nil)
        application.registerUserNotificationSettings(notificationSettings)
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.hcpt.UEFAEuro" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "UEFAEuro", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != UIUserNotificationType() {
            application.registerForRemoteNotifications()
        }
        
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let info = userInfo["aps"] as? Dictionary<String, AnyObject>
        {
            let alertController = UIAlertController(title: "kAppName".localized, message: String(describing: info["alert"]!), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "kOk".localized, style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.gotoDetailMatchVCFromPush(userInfo as NSDictionary)
                
            }
            let cancelAction = UIAlertAction(title: "kClOSE".localized, style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        completionHandler(UIBackgroundFetchResult.noData)
        
    }
    
    
    func gotoDetailMatchVCFromPush(_ notification: NSDictionary){
        UIApplication.shared.applicationIconBadgeNumber = 0
        let info = notification["aps"] as? Dictionary<String, AnyObject>
        let matchId = info!["body"] as? String
        APIManager.getMatchDetail(matchId ?? ""){ (isSuccess, message, objMatch) in
            switch isSuccess{
            case false:
                break
            case true:
                DispatchQueue.main.async(execute: {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let detailMatchVC = storyboard .instantiateViewController(withIdentifier: "DetailMatchControllerID") as!DetailMatchController
                    detailMatchVC.objMatch = objMatch
                    detailMatchVC.disMiss = true
                    
                    self.window?.rootViewController?.present(detailMatchVC, animated: false, completion: {
                        
                    })
                    
                })
                break
            }
        }
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        completionHandler([.alert, .badge, .sound])
    }
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
        let aps = userInfo["aps"] as! [String: AnyObject]
        self.gotoDetailMatchVCFromPush(aps as NSDictionary)
        completionHandler()
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenChars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
        var tokenString = ""
        
        for i in 0..<deviceToken.count {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        print("Device Token:", tokenString)
        GlobalEntities.gIME = tokenString
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            self.registerPushWithServer(tokenString)
            
        }
        
        
    }
    func registerPushWithServer(_ token: String){
        APIManager.registerDevice(token) { (isSuccess, message) in
            switch isSuccess{
            case false:
                print(message)
                break
            case true:
                print("register success")
                break
            }
        }
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register:", error)
        
    }
    
    
    
}


