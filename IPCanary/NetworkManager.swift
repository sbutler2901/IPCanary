//
//  NetworkManager.swift
//  IPCanary
//
//  Created by Seth Butler on 12/16/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import Foundation
import Alamofire

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
    
    // TODO: - Prevent spamming of server
    private func networkQueryIP(completionHandler: ((String?)->())?) {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        Alamofire.request(host, method: .get, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
                switch response.result {
                case .success:
                    
                    guard let data = response.data, let utf8Text = String(data: data, encoding: .utf8),
                        let json = try? JSONSerialization.jsonObject(with: data, options: []),
                        let dictionary = json as? [String: Any], let currentAddress = dictionary["ip"] as? String else {
                            print("There was an error getting the IP");
                            self.currentIPAddress.setAddress(address: "0.0.0.0", date: Date())
                            self.delegate?.ipUpdated()
                            completionHandler?(nil)
                            break
                    }
                    print("Data: \(utf8Text)")
                    
                    let currentDate = Date()
                    
                    self.currentIPAddress.setAddress(address: currentAddress, date: currentDate)
                    self.delegate?.ipUpdated()
                    completionHandler?(currentAddress)
                    
                case .failure(let error):
                    //print("Request: \(response.request)")
                    //print("Response: \(response.response)")
                    print("There was an error requesting the IP: \(error)")
                    completionHandler?(nil)
                }
        }
    }
}
