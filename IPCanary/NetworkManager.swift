//
//  NetworkManager.swift
//  IPCanary
//
//  Created by Seth Butler on 12/16/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let host = "https://ifconfig.co"

protocol NetworkManagerUpdatable {
    func ipUpdated()
}

class NetworkManager {
    
    var currentIPAddress: IPAddress
    
    var delegate: NetworkManagerUpdatable?

    init() {
        self.currentIPAddress = IPAddress()
    }
    
    func refreshIP(completionHandler: ((String?)->())?) {
        networkQueryIP(completionHandler: completionHandler)
    }
    
    private func parseRequestedData(data: Data) {
        //let utf8Text = String(data: data, encoding: .utf8)
        //print("Pre-parsed Data: \(utf8Text)")

        let json = JSON(data: data)
        
        print("Post-parsed Data: \(json)")
        
        self.currentIPAddress.setAddress(address: json["ip"].stringValue, city: json["city"].stringValue, country: json["country"].stringValue, hostname: json["hostname"].stringValue, date: Date())
    }
    
    // TODO:
    //  1. Prevent spamming of server
    //  2. expand info displayed
    //  3. handle various server status codes
    private func networkQueryIP(completionHandler: ((String?)->())?) {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        Alamofire.request(host, method: .get, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                            print("There was an error getting the IP");
                            self.currentIPAddress = IPAddress()
                            self.delegate?.ipUpdated()
                            completionHandler?(nil)
                            break
                    }

                    self.parseRequestedData(data: data)
                    self.delegate?.ipUpdated()
                    completionHandler?(self.currentIPAddress.getIPAddress())
                    
                case .failure(let error):
                    //print("Request: \(response.request)")
                    //print("Response: \(response.response)")
                    print("There was an error requesting the IP: \(error)")
                    completionHandler?(nil)
                }
        }
    }
}
