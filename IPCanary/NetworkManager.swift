//
//  NetworkManager.swift
//  IPCanary
//
//  Created by Seth Butler on 12/16/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import Foundation

let host = "ifconfig.co"

protocol NetworkManagerUpdatable {
    func ipUpdated()
}

class NetworkManager {
    
    var tmpCtr: Int = 0
    
    var currentIPAddress: IPAddress
    
    var delegate: NetworkManagerUpdatable?

    init() {
        self.currentIPAddress = IPAddress()
    }
    
    func refreshIP() {
        networkQueryIP()
    }
    
    func networkQueryIP() {
        // TODO: - http update
        let newLastUpdateDate = Date()
        var newAddress: String
        tmpCtr += 1
        
        if(tmpCtr % 2 == 0) {
            newAddress = "0.0.0."
            newAddress += tmpCtr.description
        } else {
            newAddress = currentIPAddress.getAddress()
        }
        
        
        self.currentIPAddress.setAddress(address: newAddress, date: newLastUpdateDate)
        delegate?.ipUpdated()
    }
}
