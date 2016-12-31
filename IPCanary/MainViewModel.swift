//
//  MainViewModel.swift
//  IPCanary
//
//  Created by Seth Butler on 12/15/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import Foundation
import IPCanaryKit

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

        currentIP = networkManager.getCurrentIPAddress().getIPAddress()
        city = networkManager.getCurrentIPAddress().getCity()
        country = networkManager.getCurrentIPAddress().getCountry()
        hostname = networkManager.getCurrentIPAddress().getHostname()
        ipLastUpdate = networkManager.getCurrentIPAddress().getLastUpdateDate().description
        ipLastChanged = networkManager.getCurrentIPAddress().getLastChangeDate().description
        
        self.networkManager.delegate = self
    }
    
    func ipUpdated() {
        currentIP = networkManager.getCurrentIPAddress().getIPAddress()
        city = networkManager.getCurrentIPAddress().getCity()
        country = networkManager.getCurrentIPAddress().getCountry()
        hostname = networkManager.getCurrentIPAddress().getHostname()
        ipLastUpdate = networkManager.getCurrentIPAddress().getLastUpdateDate().description
        ipLastChanged = networkManager.getCurrentIPAddress().getLastChangeDate().description
        delegate?.viewModelDidUpdate()
    }
    
    func refreshIP() {
        networkManager.refreshIP()
    }
    
//    func loadData() {
//        // TODO : get the ip
//        //networkManager.refreshIP()
//    }
}
