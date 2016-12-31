//
//  MainViewModel.swift
//  IPCanary
//
//  Created by Seth Butler on 12/15/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import Foundation
import IPCanaryKit

/// Notifies implementing classes when the ViewModel has been updated
protocol ViewModelUpdatable: class {
    func viewModelDidUpdate()
}

class MainViewModel: IPCanaryKitNetworkManagerUpdatable {
    
    // MARK: - MVVM Variables

    var currentIP: String
    var city: String
    var country: String
    var hostname: String
    var ipLastUpdate: String
    var ipLastChanged: String
    var delegate: ViewModelUpdatable?

    // MARK: - Class Variables
    
    private let networkManager: IPCanaryKitNetworkManager
    
    // MARK: - MVVM Functions
    
    /// Used to request update of ViewModel data
    func refreshIP() {
        networkManager.refreshIP()
    }
    
    // MARK: - Class Functions
    
    /// Initializes the ViewModel & prepares data for ViewControllers usage
    ///
    /// - Parameter networkManager: Communicates with network host & retrieves info for ViewModel
    init(networkManager: IPCanaryKitNetworkManager) {
        self.networkManager = networkManager

        currentIP = networkManager.getCurrentIPAddress().getIPAddress()
        city = networkManager.getCurrentIPAddress().getCity()
        country = networkManager.getCurrentIPAddress().getCountry()
        hostname = networkManager.getCurrentIPAddress().getHostname()
        ipLastUpdate = networkManager.getCurrentIPAddress().getLastUpdateDate().description
        ipLastChanged = networkManager.getCurrentIPAddress().getLastChangeDate().description
        
        self.networkManager.delegate = self
    }
    
    /// Delegate function executed when the NetworkManager has received updated info from network host
    func ipUpdated() {
        currentIP = networkManager.getCurrentIPAddress().getIPAddress()
        city = networkManager.getCurrentIPAddress().getCity()
        country = networkManager.getCurrentIPAddress().getCountry()
        hostname = networkManager.getCurrentIPAddress().getHostname()
        ipLastUpdate = networkManager.getCurrentIPAddress().getLastUpdateDate().description
        ipLastChanged = networkManager.getCurrentIPAddress().getLastChangeDate().description
        delegate?.viewModelDidUpdate()
    }
}
