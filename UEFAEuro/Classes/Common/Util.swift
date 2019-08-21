//
//  Util.swift
//  InstantHelper
//
//  Created by hieu nguyen on 12/21/15.
//  Copyright © 2015 Fruity Solution. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import MapKit
class Util : NSObject {
    override init() {
        
        super.init()
    }
    class func isValidEmail(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func callNumber(_ phoneNumber:String) {
        if let phoneCallURL:URL = URL(string:"tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }

    class func heightForView(_ label:UILabel) -> CGFloat{
        label.frame = CGRect(x: 0, y: 0, width: label.frame.width, height: CGFloat.greatestFiniteMagnitude)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping


        label.sizeToFit()
        return label.frame.height
    }

//    class func textfieldIsValid(_ textField:UITextField){
//        let checkmark = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        checkmark.textAlignment = NSTextAlignment.center
//        checkmark.textColor =  colorWithHexString("#b8e986")
//        checkmark.FAIcon = FAType.FACheck
//        addUnderlineToTextfield(textField, color: colorWithHexString("#b8e986"));
//        textField.rightView = checkmark;
//    }
    
    
//    class func textfieldIsInValid(_ textField:UITextField){
//        textField.rightViewMode = UITextField.ViewMode.always
//        let checkmark = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//        checkmark.textAlignment = NSTextAlignment.center
//        checkmark.textColor = UIColor.red
//        checkmark.FAIcon = FAType.FARemove
//        addUnderlineToTextfield(textField, color: UIColor.red);
//        textField.rightView = checkmark;
//    }
    
    class func textfieldAddImageToLeft(_ textField:UITextField, imageName:String){
        textField.leftViewMode = .always
        let checkmark = UIImageView(frame: CGRect(x: 10, y: 0, width: textField.frame.size.height-10, height: textField.frame.size.height-10))
        checkmark.contentMode = .scaleAspectFit
        checkmark.image = UIImage(named: imageName)

        checkmark.tintColor = UIColor.white
        textField.leftView = checkmark;
//        
//        let btnSelectDate = UIButton(frame :CGRectMake(0, 5, 20, 20))
//        btnSelectDate.backgroundColor = UIColor.clearColor()
//        btnSelectDate.setBackgroundImage(UIImage(named: imageName), forState: .Normal)
//        textField.rightView = btnSelectDate
        
        
    }
    class func removeHTMLFromString(_ string: String)->String{
         return string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    class func getStatusPostedBy(_ username: String, atDate date:Date)->String{
        let minute = Util.durationTimeFromDate(date)
        var time = "1 minute ago"
        if minute > 60{
            time = "\(NSString(format:"%.0f", minute/60)) minutes ago"
        }
        if minute > 3600{
            time = "\(NSString(format:"%.0f", (minute/60).truncatingRemainder(dividingBy: 60))) hours ago"
        }
        if minute > 86400{
            time = "\(NSString(format:"%.0f", minute/86400)) days ago"
        }
        return "\(time)"
        

    }
    class func Alert(_ View: UIViewController, Title: String, TitleColor: UIColor, Message: String, MessageColor: UIColor, BackgroundColor: UIColor, BorderColor: UIColor, ButtonColor: UIColor, accept: @escaping ()-> ()) {
        
        let TitleString = NSAttributedString(string: Title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : TitleColor])
        let MessageString = NSAttributedString(string: Message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : MessageColor])
        
        let alertController = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        
        alertController.setValue(TitleString, forKey: "attributedTitle")
        alertController.setValue(MessageString, forKey: "attributedMessage")
        
        let okAction = UIAlertAction(title: "ACCEPT", style: .default) { (action) in
            accept()
        }
        

        alertController.addAction(okAction)

        
        
        let subview = alertController.view.subviews.first! as UIView
        let alertContentView = subview.subviews.first! as UIView
        alertContentView.backgroundColor = BackgroundColor
        alertContentView.layer.cornerRadius = 10
        alertContentView.alpha = 1
        alertContentView.layer.borderWidth = 1
        alertContentView.layer.borderColor = BorderColor.cgColor
        
        
        //alertContentView.tintColor = UIColor.whiteColor()
        alertController.view.tintColor = ButtonColor
        
        View.present(alertController, animated: true) {

        }
    }
    
    
    class func addUnderlineToTextfield(_ textfield : UITextField, color:UIColor){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: textfield.frame.size.height - width, width:  textfield.frame.size.width+10, height: textfield.frame.size.height)
        
        border.borderWidth = width
        textfield.layer.addSublayer(border)
        textfield.layer.masksToBounds = true
    }
    
    class func addTextAttribute(_ font1 : UIFont , font2 : UIFont,  text1 : String , text2 : String , color1 : UIColor , color2 : UIColor)->NSAttributedString{
        let att1 :Dictionary = [ NSAttributedString.Key.font : font1,
                                 NSAttributedString.Key.foregroundColor : color1]
        
        let myAttributedString = NSMutableAttributedString (string: text1, attributes:att1)
        

        let att2 :Dictionary = [ NSAttributedString.Key.font : font2,
                                 NSAttributedString.Key.foregroundColor : color2]
        
        let secondAttString = NSMutableAttributedString (string: text2, attributes:att2)
        
        myAttributedString.append(secondAttString);
        
        return  myAttributedString
    }
    
    class func colorWithHexString (_ hex:String) -> UIColor {
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    
    class func colorWithHexString (_ hex:String, alpha: CGFloat) -> UIColor {
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    class func stringFromDateWithFormat(_ format: String, fromDate date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    class func dateFromStringWithFormat(_ format: String, fromDate date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: date)!
    }
    
    class func durationTimeFromDate(_ date: Date)->Double{
        let elapsedTime = Date().timeIntervalSince(date)
        let duration = Double(elapsedTime)
        return duration
    }
    
    class func textfieldFloatTopFont()->UIFont{
        var size = CGFloat(10.0)
        if UIDevice.current.userInterfaceIdiom == .pad{
            size = CGFloat(14.0)
        }
        return UIFont(name: "OpenSans", size: size)!
    }

    class func defaultLightFont()->UIFont{
        var size = CGFloat(12.0)
        if UIDevice.current.userInterfaceIdiom == .pad{
            size = CGFloat(18.0)
        }
        return UIFont(name: "OpenSans-Light", size: size)!
    }
    
    class func defaultBigFont()->UIFont{
        var size = CGFloat(18.0)
        if UIDevice.current.userInterfaceIdiom == .pad{
            size = CGFloat(24.0)
        }
        return UIFont(name: "OpenSans", size: size)!
    }
    
    class func defaultNormalFont()->UIFont{
        var size = CGFloat(12.0)
        if UIDevice.current.userInterfaceIdiom == .pad{
            size = CGFloat(18.0)
        }
        return UIFont(name: "OpenSans", size: size)!
    }
    

    
    class func defaultSmallFont()->UIFont{
        var size = CGFloat(10.0)
        if UIDevice.current.userInterfaceIdiom == .pad{
            size = CGFloat(14.0)
        }
        return UIFont(name: "OpenSans", size: size)!
    }
    
    
    class func defaultBoldFont()->UIFont{
        var size = CGFloat(12.0)
        if UIDevice.current.userInterfaceIdiom == .pad{
            size = CGFloat(18.0)
        }
        return UIFont(name: "OpenSans-Bold", size: size)!
    }
    
    class func defaultPeIconStrokeFont()->UIFont{
        var size = CGFloat(20.0)
        if UIDevice.current.userInterfaceIdiom == .pad{
            size = CGFloat(30.0)
        }
        return UIFont(name: "Pe-icon-7-stroke", size: size)!
    }
    
    
    
    class func randomWithinDaysBeforeToday(_ days: Int) -> Date {
        let today = Date()
        let gregorian = Calendar(identifier: .gregorian)
    
//            else {
//            print("no calendar \"NSCalendarIdentifierGregorian\" found")
//            return today
//        }
        
        let r1 = arc4random_uniform(UInt32(days))
        let r2 = arc4random_uniform(UInt32(23))
        let r3 = arc4random_uniform(UInt32(23))
        let r4 = arc4random_uniform(UInt32(23))
        
        var offsetComponents = DateComponents()
        offsetComponents.day = Int(r1) * -1
        offsetComponents.hour = Int(r2)
        offsetComponents.minute = Int(r3)
        offsetComponents.second = Int(r4)
        
        guard let rndDate1 = (gregorian as NSCalendar).date(byAdding: offsetComponents, to: today, options: []) else {
            print("randoming failed")
            return today
        }
        return rndDate1
    }
    
    //// SwiftRandom extension
    class func randomDate() -> Date {
        let randomTime = TimeInterval(arc4random_uniform(UInt32.max))
        return Date(timeIntervalSince1970: randomTime)
    }
    
    class func daysBetweenDate(_ startDate: Date, endDate: Date) -> Int
    {
        return (Calendar.current as NSCalendar).components(.day, from: startDate, to: endDate, options: []).day!
    }
    class func getDayFromDate(_ date:Date)->Int{
        return (Calendar.current as NSCalendar).component(.day, from: date)
    }
    
    ////NSUserDefaultclass function
    
    class func isKeyExits(_ key:String) -> Bool {
        if (UserDefaults.standard.object(forKey: key) != nil) {
            return true
        }else {
            return false
        }
    }
    
    class func setObject(_ value:NSObject, forKey key:String){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getObjectForkey(_ key:String)->NSObject{
        return UserDefaults.standard.object(forKey: key)! as! NSObject
    }
    
    class func setBool(_ value:Bool, forKey key:String){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func getBoolForKey(_ key:String)->Bool{
        return UserDefaults.standard.bool(forKey: key)
    }
    class func removeObjectForKey(_ key:String){
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    class func resizeImage(_ image: UIImage, newWidth: CGFloat) -> UIImage {
        

        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newWidth))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newWidth))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
//    class func convertImageToBase64(_ image: UIImage) -> String {
//
//        let imageData = UIImage.jpegData(image) //UIImageJPEGRepresentation(image, 0.5)
//        let base64String = self.percentEscapeString(imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))
//        
//        return base64String
//
//    }// end convertImageToBase64
    
    
    // prgm mark ----
    
    // convert images into base64 and keep them into string
    
    class func convertBase64ToImage(_ base64String: String) -> UIImage {
        
        let decodedData = Data(base64Encoded: base64String, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters) 
        
        let decodedimage = UIImage(data: decodedData!)
        
        return decodedimage!
        
    }
   
   
   
   
    class func percentEscapeString(_ string: String) -> String {
        return CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
            string as CFString!,
            nil,
            ":/?@!$&'()*+,;=" as CFString!,
            CFStringBuiltInEncodings.UTF8.rawValue) as String;
    }

    
    
    class func showAnimatedProgressHUD() {
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 120
        config.backgroundColor = UIColor(red:0.03, green:0.82, blue:0.7, alpha:0)
        config.spinnerColor = .white
        config.spinnerLineWidth = 2.0
        config.foregroundColor = UIColor.black
        config.foregroundAlpha = 0.3
        SwiftLoader.setConfig(config)
        SwiftLoader.show(true)
        
    }
    class func dismissProgressHUD(){
        SwiftLoader.hide()
    }
    class func showAnimatedStatusProgressHUD(_ title: String) {
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 120
        config.backgroundColor = UIColor(red:0.03, green:0.82, blue:0.7, alpha:0)
        config.spinnerColor = .white
        config.titleTextColor = .white
        config.spinnerLineWidth = 2.0
        config.foregroundColor = UIColor.black
        config.foregroundAlpha = 0.3
        SwiftLoader.setConfig(config)
        SwiftLoader.show(title, animated: true)
    }
    
        
    class func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }



    
    class func getLocationNameByCoordinate(_ latitude:Double, longitude:Double,blockCompletion completion: @escaping (_ name:String?) -> ()){
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        var name = ""
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            

            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            

            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                name = "\(locationName)"
            }

            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                name = "\(name) \(street)"
            }
            
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                name = "\(name) \(city)"
            }
            
            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                name = "\(name) \(country)"
            }
            completion(name)
        })
        
    }
    class func addConstraitsFromView(_ view:UIView, toView:UITableViewCell){

        view.removeConstraints(view.constraints)
        let leftConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        toView.addConstraint(leftConstraint)
        
        let rightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        toView.addConstraint(rightConstraint)
        
        let topConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        toView.addConstraint(topConstraint)
        
        let bottomConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -20)
        toView.addConstraint(bottomConstraint)
    }
    
}
extension String {
    
    public func urlEncode() -> String {
        let encodedURL = CFURLCreateStringByAddingPercentEscapes(nil,
            self as NSString,
            nil,
            "!@#$%&*'();:=+,/?[]" as CFString!,
            CFStringBuiltInEncodings.UTF8.rawValue)
        return encodedURL! as String
    }
}
extension Date {
    func yearsFrom() -> Int{
        
        return (Calendar.current as NSCalendar).components(.year, from: Date(), to: self, options: []).year!
    }
    func monthsFrom() -> Int{
        return (Calendar.current as NSCalendar).components(.month, from: Date(), to: self, options: []).month!
    }
    func weeksFrom() -> Int{
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: Date(), to: self, options: []).weekOfYear!
    }
    func daysFrom() -> Int{
        return (Calendar.current as NSCalendar).components(.day, from: Date(), to: self, options: []).day!
    }
    func hoursFrom() -> Int{
        return (Calendar.current as NSCalendar).components(.hour, from: Date(), to: self, options: []).hour!
    }
    func minutesFrom() -> Int{
        return (Calendar.current as NSCalendar).components(.minute, from: Date(), to: self, options: []).minute!
    }
    func secondsFrom() -> Int{
        return (Calendar.current as NSCalendar).components(.second, from: Date(), to: self, options: []).second!
    }
    
}

extension Int32 {
    static func random(_ lower: Int32 = min, upper: Int32 = max) -> Int32 {
        let r = arc4random_uniform(UInt32(Int64(upper) - Int64(lower)))
        return Int32(Int64(r) + Int64(lower))
    }
}
extension Array {
    mutating func removeObject<U: Equatable>(_ object: U) -> Bool {
        for (idx, objectToCompare) in self.enumerated() {  //in old swift use enumerate(self)
            if let to = objectToCompare as? U {
                if object == to {
                    self.remove(at: idx)
                    return true
                }
            }
        }
        return false
    }
}

