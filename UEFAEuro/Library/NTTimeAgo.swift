//
//  NTTimeAgo.swift
//  Comic
//
//  Created by Ngọc Toán on 5/6/17.
//  Copyright © 2017 Hicom David. All rights reserved.
//

import UIKit

let SECOND:Int = 1
let MINUTE = (SECOND * 60)
let HOUR   = (MINUTE * 60)
let DAY    = (HOUR   * 24)
let WEEK   = (DAY    * 7)
let MONTH  = (DAY    * 31)
let YEAR   = (DAY * 365)


class NTTimeAgo: NSObject {
    
    
    class func timeAgoSinceDate(_ date:Date) -> String {
        let now = Date()
        let secondsSince = -date.timeIntervalSince(now as Date)
        
        if(secondsSince < 0){
            return "In The Future"
        }
        if (Int(secondsSince) < MINUTE) {
            return "Just now"
        }
        if (Int(secondsSince) < HOUR) {
            return formatMinutesAgo(secondsSince)
        }
        if (Int(secondsSince) < DAY) {
            return formatAsDay(secondsSince)
        }
        if (Int(secondsSince) < WEEK) {
            return formatAsWeek(secondsSince)
        }
        if (Int(secondsSince) < YEAR) {
            return formatAsLastYear(date)
        }
        else{
            return formatAsOther(date)
        }
    }
    
    class func formatMinutesAgo(_ second:TimeInterval) -> String {
        let minutesSince =  Int(second) / MINUTE
        return (minutesSince == 1) ? "1 minute ago":"\(minutesSince) minutes ago"
    }
    class func formatAsDay(_ second:TimeInterval) -> String {
        let minutesSince =  Int(second) / HOUR
        return (minutesSince == 1) ? "1 hour ago":"\(minutesSince) hours ago"
    }
    class func formatAsWeek(_ second:TimeInterval) -> String {
        let minutesSince =  Int(second) / DAY
        return (minutesSince == 1) ? "1 day ago":"\(minutesSince) days ago"
    }
    class func formatAsLastYear(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: date as Date)
    }
    class func formatAsOther(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL d, yyyy"
        return dateFormatter.string(from: date as Date)
    }
    
    
}
