//
//  IPCanaryKitIPAddress.swift
//  IPCanaryKit
//
//  Created by Seth Butler on 12/20/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import Foundation

/// Reprents an IP address & its corresponding important info
public class IPCanaryKitIPAddress {
    
    // MARK: - Class Variables

    private var address: String
    private var city: String
    private var country: String
    private var hostname: String
    private var lastUpdateDate: Date
    private var lastChangeDate: Date
    
    // MARK: - Class Functions

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
    
    init(address: String, city: String, country: String, hostname: String, date: Date ) {
        self.address = address
        self.city = city
        self.country = country
        self.hostname = hostname
        lastUpdateDate = date
        lastChangeDate = lastUpdateDate
    }
    
    func setAddress(address: String, city: String, country: String, hostname: String) {
        let newDate = Date()
        if(self.address != address) {
            self.lastChangeDate = newDate
            self.address = address
            self.city = city
            self.country = country
            self.hostname = hostname
        }
        self.lastUpdateDate = newDate
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
    
    public func getIPAddress() -> String {
        return address
    }
    
    public func getCity() -> String {
        return city
    }
    
    public func getCountry() -> String {
        return country
    }
    
    public func getHostname() -> String {
        return hostname
    }
    
    public func getLastUpdateDate() -> Date {
        return lastUpdateDate
    }
    
    public func getLastChangeDate() -> Date {
        return lastChangeDate
    }
}
