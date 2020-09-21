//
//  ApiCalls.swift
//  Ibakatv
//
//  Created by Nwudo Ebuka on 1/8/20.
//  Copyright © 2020 Nwudo Ebuka. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON

protocol IMakeAPICalls {
    func handleSuccessResponse(_ responseJson: JSON ,_ requestCode: Int,_ statusCode:Int)
    func handleFailureResponse(_ responseJson: JSON,_ requestCode: Int,_ statusCode:Int)
}

class ApiCalls {

 
    static  func makeGetRequestWithOutHeaderAndParameters (_ url : String ,_ listner : IMakeAPICalls,_ requestCode:Int) {
     
        AF.request(url,
                          method: .get,encoding: JSONEncoding.default).responseJSON { response in
                            let statusCode: Int = (response.response?.statusCode ?? 15179)
                            switch response.result {
                            case .success(let value):
                                let json = JSON(value)
                               print(json)
                                         listner.handleSuccessResponse(json , requestCode,statusCode ?? 0)
                                
                            case .failure(let error):
                                let json = JSON(error)
                                  print(json)
                                listner.handleFailureResponse(json , requestCode,statusCode ?? 0)
                            }
        }
    }
    
    static func saveJSON(json: JSON, key:String){
        let defaults = UserDefaults.standard
        let jsonString = json.rawString()!
        defaults.setValue(jsonString, forKey: key)
        defaults.synchronize()
    }
    
    static func getJSON(_ key: String)->JSON {
        var p = ""
        let defaults = UserDefaults.standard
        if let buildNumber = defaults.value(forKey: key) as? String {
            p = buildNumber
        }else {
            p = ""
        }
        if  p != "" {
            if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                return try! JSON(data: json)
            } else {
                return JSON("nil")
            }
        } else {
            return JSON("nil")
        }
    }

}
