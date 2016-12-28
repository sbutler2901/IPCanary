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
import UserNotifications

let host = "https://ifconfig.co"

protocol NetworkManagerUpdatable {
    func ipUpdated()
}

class NetworkManager {
    
    //MARK: - Class Variables
    
    private var lastRequestDate: Date
    private let spamRequestsWaitTime: Int = 15           // Manual network request wait time
    private let autoRefreshFreq: Double = 60.0               // Number of seconds before the IP address is automatically refreshed
    
    let notificationManager: NotificationManager
    
    var currentIPAddress: IPAddress
    var delegate: NetworkManagerUpdatable?

    // MARK: - Class Functions
    
    init(notificationManager: NotificationManager) {
        self.currentIPAddress = IPAddress()
        self.lastRequestDate = Date()
        self.notificationManager = notificationManager
        networkQueryIP()
        Timer.scheduledTimer(withTimeInterval: autoRefreshFreq, repeats: true, block: { timer in
            self.refreshIP()
        })
    }
    
    /// Makes a network request to retrieve current IP address and other info
    func refreshIP() {
        let currentRequestDate = Date()
        let secondsSinceLastRequests = currentRequestDate.seconds(from: lastRequestDate)
        
        if(secondsSinceLastRequests >= spamRequestsWaitTime) {
            networkQueryIP()
        } else {
            print("Too many consecutive requests. \(secondsSinceLastRequests)sec since last request")
        }
    }

    
    
    /// Parses raw network JSON data & updates current IP Address' info
    ///
    /// - Parameter data: Raw JSON data returned from network request to be parsed
    private func parseRequestedData(data: Data) {
        //let utf8Text = String(data: data, encoding: .utf8)
        //print("Pre-parsed Data: \(utf8Text)")

        let json = JSON(data: data)
        let newIP = json["ip"].stringValue
        
        print("Post-parsed Data: \(json)")
        
        // Uncomment when finished testing
        //if(self.currentIPAddress.getIPAddress() != newIP) {
        self.notificationManager.notifyUserOnce(title: "IP Address has Changed!", subtitle: "New IP: \(newIP)", body: nil, waitTime: 5.0)
        //}
        
        self.currentIPAddress.setAddress(address: newIP, city: json["city"].stringValue, country: json["country"].stringValue, hostname: json["hostname"].stringValue)
    }
    
    // TODO: 1. handle various server status codes
    private func networkQueryIP() {
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
                    break
                }
                
                self.parseRequestedData(data: data)
                self.delegate?.ipUpdated()
                self.lastRequestDate = Date()
                
            case .failure(let error):
                //print("Request: \(response.request)")
                //print("Response: \(response.response)")
                print("There was an error requesting the IP: \(error)")
            }
        }
    }
}
