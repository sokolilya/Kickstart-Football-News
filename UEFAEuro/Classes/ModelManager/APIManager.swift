//
//  APIManager.swift
//  Devotional
//
//  Created by tuan vn on 2/23/16.
//  Copyright © 2016 tuanvn. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



typealias RegisterDeviceComplete = (_ isSuccess: Bool, _ message: String) -> Void
typealias MatchDetailComplete = (_ isSuccess: Bool, _ message: String, _ objMatch: MatchObj?) -> Void
typealias ArrEventOfMatchComplete = (_ isSuccess: Bool, _ message: String, _ arrEvent: [EventObj]) -> Void
typealias ArrPlayerInLineUpOfMatchCompelete = (_ isSuccess: Bool, _ message: String, _ arrPlayer: [PlayerInMatchObj]) -> Void
typealias ArrRecentMatchComplete = (_ isSuccess: Bool, _ message: String, _ arrMatch: [MatchObj]) -> Void
typealias ArrListLeagueResult = (_ isSuccess: Bool, _ message: String, _ arrMatch: [LeagueObj]) -> Void
typealias ArrTeamPositionInLeague = (_ isSuccess: Bool, _ message: String, _ arrMatch: [TeamObj]) -> Void
typealias ArrTeamPositionInChampion = (_ isSuccess: Bool, _ message: String, _ arrMath: [rankChampionsleague]) -> Void

typealias ArrRecentNextComplete = (_ isSuccess: Bool, _ message: String, _ arrMatch: [MatchObj]) -> Void
typealias ArrMatchByGroupComplete = (_ isSuccess: Bool, _ message: String, _ arrMatch: [MatchObj]) -> Void
typealias ArrMatchByTeamComplete = (_ isSuccess: Bool, _ message: String, _ arrMatch: [MatchObj]) -> Void
typealias ArrMatchByTeamAndGroupComplete = (_ isSuccess: Bool, _ message: String, _ arrMatch: [MatchObj]) -> Void
typealias ArrMatchInTreeComplete = (_ isSuccess: Bool, _ message: String, _ arrMatch: [MatchInTreeObj]) -> Void
typealias ArrGroupComplete = (_ isSuccess: Bool, _ message: String, _ arrGroup: [GroupObj]) -> Void
typealias ArrGroupChampionwithErro = (_ isSuccess: Bool, _ message: String, _ arrGroup: [GroupObjTeam]) -> Void
typealias ArrWeek = (_ isSuccess: Bool, _ message: String, _ arrGroup: [WeekObj]) -> Void

typealias ArrTeamInGroupStanding = (_ iSuccess: Bool, _ message: String, _ arrTeamInGroup: [TeamInStandingObj]) -> Void
typealias ArrTeamStanding = (_ iSuccess: Bool, _ message: String, _ arrTeam: [TeamInStandingObj]) -> Void
typealias ArrPlayerTopScoreComplete = (_ isSuccess: Bool, _ message: String, _ arrPlayer: [PlayerTopScoreObj]) ->Void
typealias ArrListCountryInSettingComplete = (_ isSuccess: Bool, _ message: String, _ arrCountry: [TeamInSetting]) -> Void
typealias GetDeviceInfoComplete = (_ isSuccess: Bool, _ message: String,_ statusNoti: String, _ arrIdSelected: [String]) ->Void
typealias UpdateDeviceSettingComplete = (_ isSuccess: Bool, _ message: String) ->Void
typealias GetCurrentRoundWithLeagueId = (_ isSuccess: Bool, _ message: String,_ objMatch: MatchObj?) ->Void
typealias GetCurrentRoundWithChampion = (_ isSuccess: Bool, _ message: String,_ objMatch: rankChampionsleague?) ->Void
typealias UpdateTimeStampStartComplete = (_ isSuccess: Bool, _ message: String) ->Void
typealias ArrMatchByDateComplete = (_ isSuccess: Bool, _ message: String, _ arrMatch: [MatchObj]) -> Void
typealias ArrMatchByLeagueAndDateComplete = (_ isSuccess: Bool, _ message: String, _ arrMatch: [MatchByLeagueObj]) -> Void


class APIManager {
    static let sharedInstance = APIManager()
    struct APIList {

        static let baseUrl = "http://demo.hicominfo.com:8888/multileagues/backend/web/index.php/api/"
        static let urlRegisterDevice = "deviceRegister"
        static let urlShowDeviceSetting = "showDeviceSetting"
        static let urlUpdateDeviceSetting = "updateDeviceSetting"
        static let urlUpdateTimeStampDateStart = "settingApp"
        static let urlShowDashBoard = "showDashboard" //GetArrRecentMatchComplete
        //recent match
        static let urlShowEvent = "showEvents"//GetArrEventOfMatchComplete
        static let urlShowLineUp = "showLineup"//GetLineUpOfMatchCompelete
        static let urlShowGroup = "showGroup" //GetArrGroupComplete
        static let urlShowGroupStanding = "showGroupStanding"// GetArrGroupStanding
        static let urlShowStanding = "showStanding"
        static let urlShowRss = "showRssByLeague"
        static let urlShowTopScore = "showTopScores" //GetlistPlayerInTopScore
        static let urlShowMatchDetail = "showMatchDetail"//GetMatchDetailComplete
        static let urlShowMatchList = "showMatchList"// GetArrNextMatch
        static let urlchampionleague = "showGroupStanding"
       
        static let urlShowMatchListByClub = "showMatchListByClub"// GetArrMatchByTeam
        static let urlShowMatchListByGroup = "showMatchListByGroup"//GetArrMatchByGroup
        static let urlShowMatchListByClubAndGroup = "showMatchListByClubAndGroup" //ok
        static let urlShowTree = "showTreeView"// ok
        static let urlShowClubList = "showClubList"
        static let urlshowLeagueList = "showLeagueList"
        static let urlshowLeagueStanding  = "showLeagueStanding"
        static let urlshowMatchListByRound     = "showMatchList"
        static let urlshowMatchListByClubId = "showMatchListByClub"
        static let urlshowMatchListByClubAndRound =   "showMatchList"
        static let urlshowRoundListChampion = "showGroup"
        static let urlsGetWeek = "showRound"

    }
    
    //MARK: Function
    
    
    class func registerDevice(_ strGcm_Id: String, registerResult: RegisterDeviceComplete){
        let strUrl = APIList.baseUrl + APIList.urlRegisterDevice
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let param = ["gcm_id": strGcm_Id,
                     "ime": strGcm_Id,
                     "type": "2"]
        Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            //
        }
        
    }
    
    class func getDeviceSetting(_ ime: String){
    
    }
    
    class func updateDeviceSetting(_ ime: String, status: String, clubId: String, UpDateDeviceResult: @escaping UpdateDeviceSettingComplete){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let strUrl = APIList.baseUrl + APIList.urlUpdateDeviceSetting
//        Alamofire.request(.GET, strUrl, parameters: ["ime" : ime, "status" : status, "clubId" : clubId]).responseJSON { (response) in
      let param = ["ime" : ime, "status" : status, "clubId" : clubId, "leagueId":GlobalEntities.leagueId]
       Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
                
            case.failure(let err):
                UpDateDeviceResult(false, err.localizedDescription)
                break
            case.success(let data):
                let jsonObj = JSON(data)
                let status = jsonObj["status"].string
                if status?.uppercased() == "ERROR" {
                    UpDateDeviceResult(false, jsonObj["message"].string!)
                }else{
                    UpDateDeviceResult(true, "Successfuly")
                }
                break
            }
        }
    }
   
   //func MultiLeague
   
   class func getListLeague(_ getListLeagueResult: @escaping ArrListLeagueResult){
      let strUrl = APIList.baseUrl + APIList.urlshowLeagueList
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      Alamofire.request(strUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
         debugPrint(response)
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
         switch response.result{
         case .success(let data):
            if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
               let jsonObj = JSON(data)
               GlobalEntities.isDemo = jsonObj["demo"].stringValue
               let arrObjMatch = jsonObj["data"].arrayObject!
               var arrLeagueResult = [LeagueObj]()
               for objOfArr in arrObjMatch {
                  arrLeagueResult.append(LeagueObj(dict:JSON(objOfArr)))
                  
               }
               getListLeagueResult(true, "", arrLeagueResult)
               break
            }else{
               getListLeagueResult(false,JSON(data)["message"].stringValue , [])
               break
            }
         case .failure(let error):
            getListLeagueResult(false, error.localizedDescription, [])
            break
         }
      }
   }
    
    
    class func getListChampionwithErro (_arrChampionwithErro: @escaping ArrGroupChampionwithErro){
        let strUrl = APIList.baseUrl + APIList.urlshowRoundListChampion
        let param = ["leagueId":GlobalEntities.leagueId]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            debugPrint(response)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                _arrChampionwithErro(false, err.localizedDescription, [])
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
                    let jsonArrGroup = JSON(data)["data"].arrayValue
                    var arrGroupResult = [GroupObjTeam]()
                    for dicObj in jsonArrGroup{
                        let objGroup = GroupObjTeam()
                        objGroup.groupName = JSON(dicObj)["name"].stringValue
                        objGroup.gruopId = JSON(dicObj)["id"].stringValue
                        arrGroupResult.append(objGroup)
                    }
                    _arrChampionwithErro(true, "", arrGroupResult)
                    break
                }else{
                    _arrChampionwithErro(false,JSON(data)["message"].stringValue , [])
                    break
                }
                
            }
        }
    }
   
   class func getListWeek (_arrChampionwithErro: @escaping ArrWeek){
      let strUrl = APIList.baseUrl + APIList.urlsGetWeek
      let param = ["leagueId":GlobalEntities.leagueId]
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
         debugPrint(response)
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
         switch response.result{
         case.failure(let err):
            _arrChampionwithErro(false, err.localizedDescription, [])
            break
         case.success(let data):
            if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
               let jsonArrGroup = JSON(data)["data"].arrayValue
               var arrGroupResult = [WeekObj]()
               for dicObj in jsonArrGroup{
                  let objGroup = WeekObj()
                  objGroup.weekName = JSON(dicObj)["name"].stringValue
                  objGroup.weekId = JSON(dicObj)["id"].stringValue
                  objGroup.currentWeek = JSON(dicObj)["current"].stringValue
                  arrGroupResult.append(objGroup)
               }
               _arrChampionwithErro(true, "", arrGroupResult)
               break
            }else{
               _arrChampionwithErro(false,JSON(data)["message"].stringValue , [])
               break
            }
            
         }
      }
   }

    
    class func getListPositionInChampion(_getArrTeamPositionInChamp: @escaping ArrTeamPositionInChampion) {
        let strUrl = APIList.baseUrl + APIList.urlchampionleague
        let param = ["leagueId":GlobalEntities.leagueId]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        debugPrint(response)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                _getArrTeamPositionInChamp(false, err.localizedDescription, [])
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
                    let jsonArrGroup = JSON(data)["data"].arrayObject!
                    var arrGroupResult = [rankChampionsleague]()
                    
                    for dicObj in jsonArrGroup{
                        let objGroup = rankChampionsleague()
                        objGroup.groupID = JSON(dicObj)["id"].stringValue
                        objGroup.groupName = JSON(dicObj)["name"].stringValue
                        let jsonArrClubInGroup = JSON(dicObj)["teams"].arrayValue
                        var arrClub = [groupObj]()
                        for dicObj in jsonArrClubInGroup{
                            let objClub = groupObj()
                            objClub.SttID = JSON(dicObj)["position"].stringValue
                            objClub.TeamID = JSON(dicObj)["name"].stringValue
                            objClub.Played = JSON(dicObj)["played"].stringValue
                            objClub.WinID = JSON(dicObj)["win"].stringValue
                            objClub.DrawID = JSON(dicObj)["draw"].stringValue
                            objClub.LostID = JSON(dicObj)["lose"].stringValue
                            objClub.GDID = JSON(dicObj)["gDiff"].stringValue
                            objClub.PtsID = JSON(dicObj)["point"].stringValue
                            arrClub.append(objClub)
                        }
                        objGroup.groupArrClup = arrClub
                        arrGroupResult.append(objGroup)
                    }
                    _getArrTeamPositionInChamp(true, "", arrGroupResult)
                    break
                }else{
                    _getArrTeamPositionInChamp(false,JSON(data)["message"].stringValue , [])
                    break
                }
            }
        }
    }
    
   class func getListTeamPositionInLeague(_ getArrTeamPositionInLeague: @escaping ArrTeamPositionInLeague){
      let strUrl = APIList.baseUrl + APIList.urlshowLeagueStanding
      let param = ["leagueId":GlobalEntities.leagueId]
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
         debugPrint(response)
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
         switch response.result{
         case .success(let data):
            if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
               let jsonObj = JSON(data)
               let arrObjMatch = jsonObj["data"].arrayObject!
               var arrTeamResult = [TeamObj]()
               for objOfArr in arrObjMatch {
                  arrTeamResult.append(TeamObj(dict:JSON(objOfArr)))
               }
               getArrTeamPositionInLeague(true,"", arrTeamResult)
               break
            }else{
               getArrTeamPositionInLeague(false,JSON(data)["message"].stringValue , [])
               break
            }
         case .failure(let error):
            getArrTeamPositionInLeague(false, error.localizedDescription, [])
            break
         }
      }
   }
   
   

   
   
   class func getListMatchByDate(_ date: String, arrMatchResult: @escaping ArrMatchByLeagueAndDateComplete){
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      let strUrl = APIList.baseUrl + APIList.urlShowDashBoard
      let param = ["date": date, "default":"0"]
      Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
         switch response.result{
         case.failure(let err):
            arrMatchResult(false, err.localizedDescription, [])
            break
         case.success(let data):
            if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
               let jsonObj = JSON(data)
               let arrObjMatch = jsonObj["data"].arrayValue
               var arrMatchInResult = [MatchByLeagueObj]()
               for objOfArr in arrObjMatch {
                  let League = MatchByLeagueObj()
                     League.leagueId = JSON(objOfArr)["leagueId"].stringValue
                     let arrMatch = JSON(objOfArr)["match"].arrayValue
                     var arrMatchResult = [MatchObj]()
                     for objMatch in arrMatch{
                     arrMatchResult.append(MatchObj(dict:JSON(objMatch)))
                  }
                     League.arrMatch = arrMatchResult
                  arrMatchInResult.append(League)
               }
               
               arrMatchResult(true, "", arrMatchInResult)
            }else{
               arrMatchResult(false, JSON(data)["message"].stringValue, [])
               break
            }
         }
      }
   }
   
   class func getListMatchByDefault(_ date: String, arrMatchResult: @escaping ArrMatchByLeagueAndDateComplete){
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      let strUrl = APIList.baseUrl + APIList.urlShowDashBoard
      let param = ["date": date, "default":"1"]
      Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
         switch response.result{
         case.failure(let err):
            arrMatchResult(false, err.localizedDescription, [])
            break
         case.success(let data):
            if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
               let jsonObj = JSON(data)
               let arrObjMatch = jsonObj["data"].arrayValue
               var arrMatchInResult = [MatchByLeagueObj]()
               for objOfArr in arrObjMatch {
                  let League = MatchByLeagueObj()
                  League.leagueId = JSON(objOfArr)["leagueId"].stringValue
                  let arrMatch = JSON(objOfArr)["match"].arrayValue
                  var arrMatchResult = [MatchObj]()
                  for objMatch in arrMatch{
                     arrMatchResult.append(MatchObj(dict:JSON(objMatch)))
                  }
                  League.arrMatch = arrMatchResult
                  arrMatchInResult.append(League)
               }
               
               arrMatchResult(true, "", arrMatchInResult)
            }else{
               arrMatchResult(false, JSON(data)["message"].stringValue, [])
               break
            }
         }
      }
   }
   
   
   
   
   
   
    class func gettCurrentChampoinLeague (_championsID:String, matchObj:@escaping GetCurrentRoundWithLeagueId){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let strUrl = APIList.baseUrl + APIList.urlchampionleague
        let param = ["leagueId": _championsID, "roundId":"0"]
        Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                matchObj(false, err.localizedDescription, nil)
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
                    let jsonObj = JSON(data)
                    let arrObjMatch = jsonObj["data"].arrayValue
                    let objOfArr = arrObjMatch[0]
                    let objMatchResult = MatchObj(dict:objOfArr)
                    matchObj(true, "",objMatchResult )
                }else{
                    matchObj(false, JSON(data)["message"].stringValue, nil)
                    break
                }
            }
        }
    }
    

   class func getCurrentRoundWithLeague(_ leagueId: String, matchObj: @escaping GetCurrentRoundWithLeagueId){
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      let strUrl = APIList.baseUrl + APIList.urlshowMatchListByRound
      let param = ["leagueId": leagueId, "roundId":"", "groupId": "", "clubId": ""]
      Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
         switch response.result{
         case.failure(let err):
            matchObj(false, err.localizedDescription, nil)
            break
         case.success(let data):
            if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
               let jsonObj = JSON(data)
               let arrObjMatch = jsonObj["data"].arrayValue
               if arrObjMatch.count > 0{
               let objOfArr = arrObjMatch[0]
               let objMatchResult = MatchObj(dict:objOfArr)
               matchObj(true, "",objMatchResult )
               }
               else{
                  matchObj(false, "", nil)
               }
            }else{
               matchObj(false, JSON(data)["message"].stringValue, nil)
               break
            }
         }
      }
   }
   
   
   class func getListMatchByTeamWeekAndGruop(_ round: String ,_ gruop: String,_ teamId: String, arrMatchResult: @escaping ArrMatchByDateComplete){
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      let strUrl = APIList.baseUrl + APIList.urlshowMatchListByRound
         let param = ["roundId": round,"groupId": gruop,"clubId": teamId, "leagueId":GlobalEntities.leagueId] as [String : Any]
      Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
         switch response.result{
         case.failure(let err):
            arrMatchResult(false, err.localizedDescription, [])
            break
         case.success(let data):
            if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
               let jsonObj = JSON(data)
               let arrObjMatch = jsonObj["data"].arrayValue
               if arrObjMatch.count == 0{
                  arrMatchResult(false, "Data not update yet", [])
               }else{
               var arrMatchInResult = [MatchObj]()
               for objOfArr in arrObjMatch {
                  arrMatchInResult.append(MatchObj(dict:JSON(objOfArr)))
               }
               arrMatchResult(true, "", arrMatchInResult)
               }
            }else{
               arrMatchResult(false, JSON(data)["message"].stringValue, [])
               break
            }
         }
      }
   }
   class func getListMatchByTeamId(_ teamId: String, arrMatchResult: @escaping ArrMatchByDateComplete){
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      let strUrl = APIList.baseUrl + APIList.urlshowMatchListByClubId
      let param = ["clubId": teamId, "leagueId":GlobalEntities.leagueId]
      Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
         switch response.result{
         case.failure(let err):
            arrMatchResult(false, err.localizedDescription, [])
            break
         case.success(let data):
            if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
               let jsonObj = JSON(data)
               let arrObjMatch = jsonObj["data"].arrayValue
               var arrMatchInResult = [MatchObj]()
               for objOfArr in arrObjMatch {
                  arrMatchInResult.append(MatchObj(dict:JSON(objOfArr)))
               }
               
               arrMatchResult(true, "", arrMatchInResult)
            }else{
               arrMatchResult(false, JSON(data)["message"].stringValue, [])
               break
            }
         }
      }
   }
   
   class func getListMatchByTeamIdAndRound(_ teamId: String,_ round: String, arrMatchResult: @escaping ArrMatchByDateComplete){
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      let strUrl = APIList.baseUrl + APIList.urlshowMatchListByClubAndRound
      let param = ["roundId": round, "clubId": teamId, "groupId": "","leagueId":GlobalEntities.leagueId] as [String : Any]
      Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
         switch response.result{
         case.failure(let err):
            arrMatchResult(false, err.localizedDescription, [])
            break
         case.success(let data):
            if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
               let jsonObj = JSON(data)
               let arrObjMatch = jsonObj["data"].arrayValue
               var arrMatchInResult = [MatchObj]()
               for objOfArr in arrObjMatch {
                  arrMatchInResult.append(MatchObj(dict:JSON(objOfArr)))
               }
               
               arrMatchResult(true, "", arrMatchInResult)
            }else{
               arrMatchResult(false, JSON(data)["message"].stringValue, [])
               break
            }
         }
      }
   }
   
   
   
   class func showCountryInSetting(_ arrListCountResult: @escaping ArrListCountryInSettingComplete){
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      let strUrl = APIList.baseUrl + APIList.urlshowLeagueStanding
      let param = ["leagueId":GlobalEntities.leagueId]
      Alamofire.request(strUrl, method: .get, parameters: param , encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
         switch response.result{
         case.failure(let err):
            arrListCountResult(false, err.localizedDescription, [])
            break
         case.success(let data):
            if JSON(data)["status"].stringValue.uppercased() == "SUCCESS"{
               let jsonArrCountry = JSON(data)["data"].arrayObject!
               var arrCountryInResult = [TeamInSetting]()
               for dicObj in jsonArrCountry{
                  let objCountry = TeamInSetting()
                  objCountry.teamId = JSON(dicObj)["id"].stringValue
                  objCountry.teamName = JSON(dicObj)["name"].stringValue
                  objCountry.teamImage = JSON(dicObj)["image"].stringValue
                  let userDefault = UserDefaults.standard
                  if let saveSetting = userDefault.string(forKey: String(format: "%@%@", KEY_SAVE_SETTING,GlobalEntities.leagueId)){
                     print("abc")
                     GlobalEntities.gArrTeamSelected = saveSetting.components(separatedBy: ",")
                     if GlobalEntities.gArrTeamSelected.contains((JSON(dicObj)["id"].stringValue)) {
                        objCountry.teamSelected = true
                     }else{
                        objCountry.teamSelected = false
                     }
                  }
                  
                  
                  var containNumber = false
                  for i in 0..<10{
                     if objCountry.teamName.range(of: "\(i)") != nil{
                        containNumber = true
                        break
                     }
                  }
                  if containNumber == false{
                     arrCountryInResult.append(objCountry)
                  }
               }
               arrListCountResult(true, "", arrCountryInResult)
               break
            }else{
               arrListCountResult(false, JSON(data)["message"].stringValue, [])
               break
            }
         }
      }
   }
   
    
    class func showTeamInSetting(_ arrListCountResult: @escaping ArrListCountryInSettingComplete){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let strUrl = APIList.baseUrl + APIList.urlchampionleague
        let param = ["leagueId":GlobalEntities.leagueId]
        Alamofire.request(strUrl, method: .get, parameters: param , encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                arrListCountResult(false, err.localizedDescription, [])
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS"{
                     let dataArr = JSON(data)["data"].arrayObject!
                        var arrCountryInResult = [TeamInSetting]()
                        for group in dataArr{
                        let teamArr = JSON(group)["teams"].arrayObject!
                        
                        for dicObj in teamArr{
                            let objCountry = TeamInSetting()
                            objCountry.teamId = JSON(dicObj)["id"].stringValue
                            objCountry.teamName = JSON(dicObj)["name"].stringValue
                            objCountry.teamImage = JSON(dicObj)["image"].stringValue
                           let userDefault = UserDefaults.standard
                           if let saveSetting = userDefault.string(forKey: String(format: "%@%@", KEY_SAVE_SETTING,GlobalEntities.leagueId)){
                              print("abc")
                              GlobalEntities.gArrTeamSelected = saveSetting.components(separatedBy: ",")
                              if GlobalEntities.gArrTeamSelected.contains((JSON(dicObj)["id"].stringValue)) {
                                 objCountry.teamSelected = true
                              }else{
                                 objCountry.teamSelected = false
                              }
                           }
                            arrCountryInResult.append(objCountry)
                        
                        }
                        
                    }
                    arrListCountResult(true, "", arrCountryInResult)
                    break
                }else{
                    arrListCountResult(false, JSON(data)["message"].stringValue, [])
                    break
                }
            }
        }
    }
   
   
   
   
   
   // WorldCup
    class func getListRecentMatch(_ getListMatchResult: @escaping ArrRecentMatchComplete){
        let strUrl = APIList.baseUrl + APIList.urlShowDashBoard
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(strUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case .success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
                let jsonObj = JSON(data)
                let arrObjMatch = jsonObj["data"].arrayObject!
                var arrMatchObjResult = [MatchObj]()
                for objOfArr in arrObjMatch {
                    arrMatchObjResult.append(MatchObj(dict:JSON(objOfArr)))
                }
                getListMatchResult(true, "", arrMatchObjResult)
                break
                }else{
                    getListMatchResult(false, JSON(data)["message"].stringValue, [])
                    break
                }
            case .failure(let error):
                getListMatchResult(false, error.localizedDescription, [])
                break
            }
        }
    }
    
    class func getListNextMatch(_ getListMatchResult: @escaping ArrRecentMatchComplete){
        let strUrl = APIList.baseUrl + APIList.urlShowDashBoard + "?nor=next"
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(strUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            debugPrint(response)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case .success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
                let jsonObj = JSON(data)
                let arrObjMatch = jsonObj["data"].arrayObject!
                var arrMatchObjResult = [MatchObj]()
                for objOfArr in arrObjMatch {
                    arrMatchObjResult.append(MatchObj(dict:JSON(objOfArr)))

                }
                getListMatchResult(true, "", arrMatchObjResult)
                break
                }else{
                    getListMatchResult(false,JSON(data)["message"].stringValue , [])
                    break
                }
            case .failure(let error):
                getListMatchResult(false, error.localizedDescription, [])
                break
            }
        }
    }
    
    class func getListEventOfMatch(_ id: String, arrEventIfSuccess: @escaping ArrEventOfMatchComplete){
        let strUrl = APIList.baseUrl + APIList.urlShowEvent
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      let param = ["id": id, "leagueId": GlobalEntities.leagueId]
        Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
//        Alamofire.request(.GET, strUrl, parameters: ["id": id]).responseJSON { (response) in
            debugPrint(response)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case .success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
                let arrEventObj = JSON(data)["data"].arrayObject!
                var arrEventObjResult = [EventObj]()
                for objDic in arrEventObj{
                    arrEventObjResult.append(EventObj(dict:JSON(objDic)))
                }
                arrEventIfSuccess(true, "", arrEventObjResult)
                break
                }else{
                    arrEventIfSuccess(false, JSON(data)["message"].stringValue, [])
                    break
                }
            case .failure(let err):
                arrEventIfSuccess(false, err.localizedDescription, [])
                break
            }
        }
    }
    
    class func getListPlayerInLineUpOfMatch(_ id: String, arrPlayerIfSuccess: @escaping ArrPlayerInLineUpOfMatchCompelete){
        let strUrl = APIList.baseUrl + APIList.urlShowLineUp
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let param = ["id": id]
        Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
//        Alamofire.request(.GET, strUrl, parameters: ["id": id]).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                arrPlayerIfSuccess(false, err.localizedDescription, [])
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
                let jsonArrPlayer = JSON(data)["data"].arrayObject!
                var arrListPlayerResult = [PlayerInMatchObj]()
                for dicObj in jsonArrPlayer{
                    arrListPlayerResult.append(PlayerInMatchObj(dict:JSON(dicObj)))
                }
                arrPlayerIfSuccess(true, "", arrListPlayerResult)
                break
                }else{
                    arrPlayerIfSuccess(false,JSON(data)["message"].stringValue , [])
                    break
                }
            }
        }
    }

    
                        
    class func getListGroup(_ arrGroupIfSuccess: @escaping ArrGroupComplete){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let strUrl = APIList.baseUrl + APIList.urlShowGroup
        Alamofire.request(strUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
//        Alamofire.request(.GET, strUrl).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                arrGroupIfSuccess(false, err.localizedDescription, [])
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
                let jsonArrGroup = JSON(data)["data"].arrayObject!
                var arrGroupResult = [GroupObj]()
                
                for dicObj in jsonArrGroup{
                    let objGroup = GroupObj()
                    objGroup.groupId = JSON(dicObj)["id"].stringValue
                    objGroup.groupName = JSON(dicObj)["name"].stringValue
                    let jsonArrClubInGroup = JSON(dicObj)["team"].arrayObject!
                    var arrClub = [ClubObj]()
                    for dicObj in jsonArrClubInGroup{
                        let objClub = ClubObj()
                        objClub.clubId = JSON(dicObj)["clubId"].stringValue
                        objClub.clubName = JSON(dicObj)["clubName"].stringValue
                        objClub.clubFiFaCode = JSON(dicObj)["fifaCode"].stringValue
                        objClub.clubImage = JSON(dicObj)["clubImage"].stringValue
                        arrClub.append(objClub)
                    }
                    objGroup.groupArrClup = arrClub
                   arrGroupResult.append(objGroup)
                }
                arrGroupIfSuccess(true, "", arrGroupResult)
                    break
                }else{
                    arrGroupIfSuccess(false,JSON(data)["message"].stringValue , [])
                    break
                }
        }
    }
}

    class func getListGroupStanding(_ id: String,arrTeamInGroupStandingSuccess: @escaping ArrTeamInGroupStanding){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let strUrl = APIList.baseUrl + APIList.urlShowGroupStanding
        let param = ["groupId": id]
        Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
//        Alamofire.request(.GET, strUrl).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                arrTeamInGroupStandingSuccess(false, err.localizedDescription, [])
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
                let jsonArrTeam = JSON(data)["data"].arrayObject!
                var arrTeamInGroupStanding = [TeamInStandingObj]()
                
                for dicObj in jsonArrTeam{
                    let objTeam = TeamInStandingObj()
                    objTeam.teamId = JSON(dicObj)["id"].stringValue
                    objTeam.teamName = JSON(dicObj)["name"].stringValue
                    objTeam.teamImage = JSON(dicObj)["image"].stringValue
                    objTeam.teamPlayed = JSON(dicObj)["played"].stringValue
                    objTeam.teamWin = JSON(dicObj)["win"].stringValue
                    objTeam.teamDraw = JSON(dicObj)["draw"].stringValue
                    objTeam.teamLose = JSON(dicObj)["lose"].stringValue
                    objTeam.teamMgFor = JSON(dicObj)["mgFor"].stringValue
                    objTeam.teamMgAgainst = JSON(dicObj)["mgAgainst"].stringValue
                    objTeam.teamGDiff = JSON(dicObj)["gDiff"].stringValue
                    objTeam.teamPoint = JSON(dicObj)["point"].stringValue
                    objTeam.teamGroup = JSON(dicObj)["group"].stringValue
                    objTeam.teamGroupId = JSON(dicObj)["groupId"].stringValue
                    objTeam.teamPosition = JSON(dicObj)["position"].stringValue
                    objTeam.teamInfo = JSON(dicObj)["clubInfo"].stringValue
                    let strTeamUrl = JSON(dicObj)["clubUrl"].stringValue
                    if strTeamUrl.count > 0{
                        objTeam.teamUrl = strTeamUrl
                    }
                    arrTeamInGroupStanding.append(objTeam)
                }
                arrTeamInGroupStandingSuccess(true, "", arrTeamInGroupStanding)
                    break
                }else{
                    arrTeamInGroupStandingSuccess(false,JSON(data)["message"].stringValue , [])
                    break
                }
            }
        }
    }
    
    class func getListPlayerTopScore(_ arrPlayerTopScoreSuccess: @escaping ArrPlayerTopScoreComplete){
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    let strUrl = APIList.baseUrl + APIList.urlShowTopScore
    let param = ["leagueId":GlobalEntities.leagueId]
//        Alamofire.request(.GET, strUrl).responseJSON { (response) in
        Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                arrPlayerTopScoreSuccess(false, err.localizedDescription, [])
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
                let jsonArrPlayer = JSON(data)["data"].arrayObject!
                var arrPlayerInTopScore = [PlayerTopScoreObj]()
                for dicPlayer in jsonArrPlayer{
                    let objPlayer = PlayerTopScoreObj()
                    objPlayer.playerId = JSON(dicPlayer)["id"].stringValue
                    objPlayer.playerName = JSON(dicPlayer)["player"].stringValue
                    objPlayer.playerClub = JSON(dicPlayer)["club"].stringValue
                    objPlayer.playerClubName = JSON(dicPlayer)["clubName"].stringValue
                    objPlayer.playerCLubImage = JSON(dicPlayer)["clubImage"].stringValue
                    objPlayer.playerGoal = JSON(dicPlayer)["goal"].stringValue
                    objPlayer.playerFIFACode = JSON(dicPlayer)["fifaCode"].stringValue
                 arrPlayerInTopScore.append(objPlayer)
                }
                arrPlayerTopScoreSuccess(true, "", arrPlayerInTopScore)
                    break
                }else{
                    arrPlayerTopScoreSuccess(false,JSON(data)["message"].stringValue , [])
                    break
                }
            }
        }
    }
    
    class func getMatchDetail(_ strId: String, matchObj: @escaping MatchDetailComplete){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let strUrl = APIList.baseUrl + APIList.urlShowMatchDetail
//        Alamofire.request(.GET, strUrl, parameters: ["id": strId]).responseJSON { (response) in
      let param = ["id": strId, "leagueId": GlobalEntities.leagueId]
        Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                matchObj(false, err.localizedDescription, nil)
                break
            case.success(let data):
//                if let
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
                let dicObj = JSON(data)["data"]
                let objMatchResult = MatchObj(dict:dicObj)
                matchObj(true, "", objMatchResult)
                }else{
                    matchObj(false,JSON(data)["message"].stringValue , nil)
                    break
                }
            }
        }
    }
    
    class func getlistAllMatch(_ arrAllMatchSuccess: @escaping ArrRecentNextComplete){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let strUrl = APIList.baseUrl + APIList.urlShowMatchList
//        Alamofire.request(.GET, strUrl).responseJSON { (response) in
        Alamofire.request(strUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                arrAllMatchSuccess(false, err.localizedDescription, [])
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
                let jsonArrMatch = JSON(data)["data"].arrayObject!
                var arrMatchInResult = [MatchObj]()
                
                for dicObj in jsonArrMatch{
                    arrMatchInResult.append(MatchObj(dict:JSON(dicObj)))
                }
                arrAllMatchSuccess(true, "", arrMatchInResult)
                }else{
                    arrAllMatchSuccess(false, JSON(data)["message"].stringValue, [])
                    break
                }
            }
                
        }
    }
    
    class func getListMatchByClub(_ clubId: String, arrMatchResult: @escaping ArrMatchByTeamComplete){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let strUrl = APIList.baseUrl + APIList.urlShowMatchListByClub
//        Alamofire.request(.GET, strUrl, parameters: ["clubId": clubId]).responseJSON { (response) in
        let param = ["clubId": clubId]
        Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                arrMatchResult(false, err.localizedDescription, [])
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS" {
                let jsonArrMatch = JSON(data)["data"].arrayObject!
                var arrMatchInResult = [MatchObj]()
                
                for dicObj in jsonArrMatch{
                    arrMatchInResult.append(MatchObj(dict:JSON(dicObj)))
                }
                arrMatchResult(true, "", arrMatchInResult)
                }else{
                 arrMatchResult(false, JSON(data)["message"].stringValue, [])
                 break
                }
            }
        }
    }
    
    class func getListMatchByGroup(_ groupId: String, arrMatchResult: @escaping ArrMatchByGroupComplete){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let strUrl = APIList.baseUrl + APIList.urlShowMatchListByGroup
//        Alamofire.request(.GET, strUrl, parameters: ["groupId": groupId]).responseJSON { (response) in
        let param = ["groupId": groupId]
        Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                arrMatchResult(false, err.localizedDescription, [])
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS"{
                let jsonArrMatch = JSON(data)["data"].arrayObject!
                var arrMatchInResult = [MatchObj]()
                
                for dicObj in jsonArrMatch{
                    arrMatchInResult.append(MatchObj(dict:JSON(dicObj)))
                }
                arrMatchResult(true, "", arrMatchInResult)
                }else{
                    arrMatchResult(false, JSON(data)["message"].stringValue, [])
                    break
                }
            }
        }
    }
    
    class func getListMatchByClubAndGroup(_ clubId: String, groupId: String, arrMatchResult: @escaping ArrMatchByTeamAndGroupComplete){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let strUrl = APIList.baseUrl + APIList.urlShowMatchListByClubAndGroup
        let param = ["clubId": clubId, "groupId": groupId]
        Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                arrMatchResult(false, err.localizedDescription, [])
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS"{
                let jsonArrMatch = JSON(data)["data"].arrayObject!
                var arrMatchInResult = [MatchObj]()
                
                for dicObj in jsonArrMatch{
                    arrMatchInResult.append(MatchObj(dict:JSON(dicObj)))
                }
                arrMatchResult(true, "", arrMatchInResult)
                }else{
                    arrMatchResult(false, JSON(data)["message"].stringValue, [])
                    break
                }
            }
        }
    }
    
    class func getListMatchInTreeKnockOut(_ arrAllMatchInTree: @escaping ArrMatchInTreeComplete){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let strUrl = APIList.baseUrl + APIList.urlShowTree
//        Alamofire.request(.GET, strUrl).responseJSON { (response) in
        Alamofire.request(strUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let err):
                arrAllMatchInTree(false, err.localizedDescription, [])
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS"{
                let jsonArrMatch = JSON(data)["data"].arrayObject!
                var arrMatchInResult = [MatchInTreeObj]()
                for dicObj in jsonArrMatch{
                    let objMatch = MatchInTreeObj()
                    objMatch.mitNo =  JSON(dicObj)["orderNo"].stringValue
                    if objMatch.mitNo == nil {
                    objMatch.mitNo = "0"
                    }
                    
                    objMatch.mitHomeId = JSON(dicObj)["homeId"].stringValue
                    objMatch.mitAwayId = JSON(dicObj)["awayId"].stringValue
                    objMatch.mitHomeName = JSON(dicObj)["home"].stringValue
                    objMatch.mitAwayname = JSON(dicObj)["away"].stringValue
                    objMatch.mitHomeScore = JSON(dicObj)["homeScore"].stringValue
                    objMatch.mitAwayScore = JSON(dicObj)["awayScore"].stringValue
                    objMatch.mitStatus = JSON(dicObj)["status"].stringValue
                    objMatch.mitHomeImage = JSON(dicObj)["homeImage"].stringValue
                    objMatch.mitAwayImage = JSON(dicObj)["awayImage"].stringValue
                    if objMatch.mitStatus == nil {
                        objMatch.mitStatus = "0"
                    }
                    
                    arrMatchInResult.append(objMatch)
                }
                arrAllMatchInTree(true, "", arrMatchInResult)
                }else{
                    arrAllMatchInTree(false, JSON(data)["message"].stringValue, [])
                    break
                }
            }
        }
    }
    
   
    
    class func getDeviceInfo(_ ime: String, result: @escaping GetDeviceInfoComplete ){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let strUrl = APIList.baseUrl + APIList.urlShowDeviceSetting
//        Alamofire.request(.GET, strUrl, parameters: ["ime":ime]).responseJSON { (response) in
         Alamofire.request(strUrl, method: .get, parameters: ["ime":ime], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result{
            case.failure(let error):
                result(false, error.localizedDescription, "", [])
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS"{
                let dataResult = JSON(data)["data"]
                var status = "0"
                if let strStatus = dataResult["status"].string{
                 status = strStatus
                }
                var strArrId = ""
                if let str: String = dataResult["clubId"].string{
                    strArrId = str
                }
//                let arrIdSelected = strArrId.componentsSeparatedByString(",")
                let arrIdSelected = strArrId.components(separatedBy: ",")
                result(true, "", status, arrIdSelected)
                break
                }else{
                    result(false, JSON(data)["message"].stringValue, "", [])
                    break
                }
            }
        }
    }
//    class func getNewUrl(_ result: @escaping (_ isSuccess: Bool, _ message: String, _ strUrl: String) ->Void) {
//        let strUrl = APIList.baseUrl + APIList.urlShowRss
//        let param = ["leagueId":GlobalEntities.leagueId]
//        Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
//            switch response.result{
//            case .failure(let err):
//                result(false, err.localizedDescription, "" )
//                break
//            case.success(let data):
//                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS"{
//                    let dataResult = JSON(data)["data"].arrayObject!
//                }else{
//                    result(false, JSON(data)["message"].stringValue, "")
//                    break
//                }
//            }
//        }
//    }
    
    class func getRssUrl(_ result: @escaping (_ isSuccess: Bool, _ message: String, _ strUrl: String) ->Void){
    let strUrl = APIList.baseUrl + APIList.urlShowRss
      let param = ["leagueId":GlobalEntities.leagueId]
         Alamofire.request(strUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .failure(let err):
                result(false, err.localizedDescription, "" )
                break
            case.success(let data):
                if JSON(data)["status"].stringValue.uppercased() == "SUCCESS"{
                let dataResult = JSON(data)["data"].arrayObject!
                    if dataResult.count == 0{
                        result(true, "", "http://www.skysports.com/rss/0,20514,11854,00.xml")

                    }else{
                        let dicObj = dataResult.first!
                                        let url = JSON(dicObj)["rss"].stringValue
                                                result(true, "", url)
                    }
                break
                }else{
                    result(false, JSON(data)["message"].stringValue, "")
                    break
                }
            }
        }
    }
    
}

 
