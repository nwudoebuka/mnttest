//
//  RepoModel.swift
//  mintbank
//
//  Created by Chukwuebuka Nwudo on 21/09/2020.
//  Copyright © 2020 Chukwuebuka Nwudo. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON
protocol RepoModelOutput{
    
    func successRepo(_ response:JSON,_ requestCode:Int,_ statusCode:Int)
    func failRepo(_ response:JSON,_ requestCode:Int,_ statusCode:Int)
    
}

class RepooModel:IMakeAPICalls{
    
    var delegate:RepoModelOutput!
    let COMMIT_REQ_CODE = 1
    //http://gogata.ng:8080/api/customer/login
    let COMMIT_URL = Constants.BASE_URL+"repos/rails/rails/commits"
    func getCommits(){
        print("method call")
        ApiCalls.makeGetRequestWithOutHeaderAndParameters(COMMIT_URL, self, COMMIT_REQ_CODE)
    }
  
    func handleSuccessResponse(_ responseJson: JSON, _ requestCode: Int, _ statusCode: Int) {
      
        delegate.successRepo(responseJson, requestCode, statusCode)
        
    }
    
    func handleFailureResponse(_ responseJson: JSON, _ requestCode: Int, _ statusCode: Int) {
        delegate.failRepo(responseJson, requestCode, statusCode)
    }
    
}
