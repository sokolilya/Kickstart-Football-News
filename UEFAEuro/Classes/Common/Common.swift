//
//  Common.swift
//  UEFAEuro
//
//  Created by HiCom on 4/14/16.
//  Copyright © 2016 Hicom Solution. All rights reserved.
//
import UIKit
import Foundation
struct MyColors{
    static func colorText() -> UIColor { return UIColor(
        red: CGFloat((0x212121 & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((0x212121 & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(0x212121 & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
        ) }
}
// Time Euro start: 1528934400
//1465554008
let TIME_STAMP_WOURLDCUP: Double = 1528934400
let ADMOBID = "ca-app-pub-6909172246232011/3884129919"


var gArrRssObj = [RssRecord]()
var gArrImgRss = [String]()
var URL_RSS = ""

let KEY_SAVE_TIME_REFRESH   = "KEY_SAVE_TIME_REFRESH"
let KEY_SAVE_REFRESH_STATUS = "KEY_SAVE_STATUS"
let KEY_SAVE_USER_NAME      =   "KEY_SAVE_USER_NAME"
let KEY_SAVE_LANGUAGE       = "KEY_SAVE_LANGUAGE"
let KEY_SAVE_SETTING       = "KEY_SAVE_SETTING"
let KEY_SAVE_ALARM       = "KEY_SAVE_ALARM"
let KEY_CHECK_NOTI       = "KEY_CHECK_NOTI"


extension String {
    var localized: String {
        let lang = UserDefaults.standard.string(forKey: KEY_SAVE_LANGUAGE)
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle.init(path: path!)
        return bundle!.localizedString(forKey: self, value: "", table: nil)
        
//        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    func toDouble() -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        //        formatter.locale = locale
        formatter.usesGroupingSeparator = true
        if let result = formatter.number(from: self)?.doubleValue {
            return result
        } else {
            return 0
        }
    }
}

