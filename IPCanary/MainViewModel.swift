//
//  MainViewModel.swift
//  IPCanary
//
//  Created by Seth Butler on 12/15/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import Foundation

protocol ViewModelUpdatable: class {
    func viewModelDidUpdate()
}

class MainViewModel: NetworkManagerUpdatable {
    
    // MARK: - Variables associated with view/viewController

    var currentIP: String
    var city: String
    var country: String
    var hostname: String
    var ipLastUpdate: String
    var ipLastChanged: String
    
    
    // MARK: - Variables an instance of the class which handle the data
    private let networkManager: NetworkManager
    
    var delegate: ViewModelUpdatable?
    
    // MARK: - Init - initialize variables to be used by view/viewcontroller
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        //super.init()
    
        currentIP = networkManager.currentIPAddress.getIPAddress()
        city = networkManager.currentIPAddress.getCity()
        country = networkManager.currentIPAddress.getCountry()
        hostname = networkManager.currentIPAddress.getHostname()
        ipLastUpdate = networkManager.currentIPAddress.getLastUpdateDate().description
        ipLastChanged = networkManager.currentIPAddress.getLastChangeDate().description
    }
    
    func ipUpdated() {
        currentIP = networkManager.currentIPAddress.getIPAddress()
        city = networkManager.currentIPAddress.getCity()
        country = networkManager.currentIPAddress.getCountry()
        hostname = networkManager.currentIPAddress.getHostname()
        ipLastUpdate = networkManager.currentIPAddress.getLastUpdateDate().description
        ipLastChanged = networkManager.currentIPAddress.getLastChangeDate().description
        delegate?.viewModelDidUpdate()
    }
    
    func refreshIP() {
        networkManager.refreshIP()
    }
    
    func loadData() {
        // TODO : get the ip
        //networkManager.refreshIP()
    }
}
