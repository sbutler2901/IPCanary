//
//  IPAddress.swift
//  IPCanary
//
//  Created by Seth Butler on 12/20/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import Foundation

class IPAddress {
    
    private var address: String
    private var city: String
    private var country: String
    private var hostname: String
    private var lastUpdateDate: Date
    private var lastChangeDate: Date
    
    init() {
        address = "0.0.0.0"
        self.city = "Unknown"
        self.country = "Unknown"
        self.hostname = "Unknown"
        lastUpdateDate = Date()
        lastChangeDate = lastUpdateDate
    }
    
    init(address: String, city: String, country: String, hostname: String ) {
        self.address = address
        self.city = city
        self.country = country
        self.hostname = hostname
        lastUpdateDate = Date()
        lastChangeDate = lastUpdateDate
    }
    
    init(address: String, city: String, country: String, hostname: String, date: Date) {
        self.address = address
        self.city = city
        self.country = country
        self.hostname = hostname
        lastUpdateDate = date
        lastChangeDate = lastUpdateDate
    }
    
    func setAddress(address: String, city: String, country: String, hostname: String, date: Date) {
        if(self.address != address) {
            self.lastChangeDate = date
            self.address = address
            self.city = city
            self.country = country
            self.hostname = hostname
        }
        self.lastUpdateDate = date
        
    }
    
    func getIPAddress() -> String {
        return address
    }
    
    func getCity() -> String {
        return city
    }
    
    func getCountry() -> String {
        return country
    }
    
    func getHostname() -> String {
        return hostname
    }
    
    func getLastUpdateDate() -> Date {
        return lastUpdateDate
    }
    
    func getLastChangeDate() -> Date {
        return lastChangeDate
    }
}
