//
//  MainViewModel.swift
//  IPCanary
//
//  Created by Seth Butler on 12/15/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import Foundation

class IPAddress {
    
    private var address: String
    private var lastUpdateDate: Date
    private var lastChangeDate: Date
    
    init() {
        address = "0.0.0.0"
        lastUpdateDate = Date()
        lastChangeDate = lastUpdateDate
    }
    
    init(address: String) {
        self.address = address
        lastUpdateDate = Date()
        lastChangeDate = lastUpdateDate
    }
    
    init(address: String, date: Date) {
        self.address = address
        lastUpdateDate = date
        lastChangeDate = lastUpdateDate
    }
    
    func setAddress(address: String, date: Date) {
        if(self.address != address) {
            self.lastChangeDate = date
            self.address = address
        }
        self.lastUpdateDate = date

    }
    
    func getAddress() -> String {
        return address
    }
    
    func getLastUpdateDate() -> Date {
        return lastUpdateDate
    }
    
    func getLastChangeDate() -> Date {
        return lastChangeDate
    }
}

protocol ViewModelUpdatable: class {
    func viewModelDidUpdate()
}

class MainViewModel: NetworkManagerUpdatable {
    
    // MARK: - Variables associated with view/viewController

    var currentIP: String
    var ipLastUpdate: String
    var ipLastChanged: String
    
    
    // MARK: - Variables an instance of the class which handle the data
    private let networkManager: NetworkManager
    
    var delegate: ViewModelUpdatable?
    
    // MARK: - Init - initialize variables to be used by view/viewcontroller
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        //super.init()
    
        currentIP = networkManager.currentIPAddress.getAddress()
        ipLastUpdate = networkManager.currentIPAddress.getLastUpdateDate().description
        ipLastChanged = networkManager.currentIPAddress.getLastChangeDate().description
    }
    
    func ipUpdated() {
        currentIP = networkManager.currentIPAddress.getAddress()
        ipLastUpdate = networkManager.currentIPAddress.getLastUpdateDate().description
        ipLastChanged = networkManager.currentIPAddress.getLastChangeDate().description
        delegate?.viewModelDidUpdate()
    }
    
    func refreshIP() {
        networkManager.refreshIP()
    }
    
    func loadData() {
        // TODO : get the ip
        networkManager.refreshIP()
    }
}
