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
    
    let networkManager: IPCanaryKitNetworkManager
    private let dateFormatter: DateFormatter = DateFormatter()
    
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
        
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM dd yyyy KK:mm:ss")
        dateFormatter.timeZone = TimeZone.current

        currentIP = networkManager.getCurrentIPAddress().getIPAddress()
        city = networkManager.getCurrentIPAddress().getCity()
        country = networkManager.getCurrentIPAddress().getCountry()
        hostname = networkManager.getCurrentIPAddress().getHostname()
        ipLastUpdate = dateFormatter.string(from: networkManager.getCurrentIPAddress().getLastUpdateDate())
        ipLastChanged = dateFormatter.string(from: networkManager.getCurrentIPAddress().getLastChangeDate())
        
        self.networkManager.delegate = self
    }
    
    /// Delegate function executed when the NetworkManager has received updated info from network host
    func ipUpdated() {
        currentIP = networkManager.getCurrentIPAddress().getIPAddress()
        city = networkManager.getCurrentIPAddress().getCity()
        country = networkManager.getCurrentIPAddress().getCountry()
        hostname = networkManager.getCurrentIPAddress().getHostname()
        ipLastUpdate = dateFormatter.string(from: networkManager.getCurrentIPAddress().getLastUpdateDate())
        ipLastChanged = dateFormatter.string(from: networkManager.getCurrentIPAddress().getLastChangeDate())
        
        delegate?.viewModelDidUpdate()
    }
}
