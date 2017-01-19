//
//  SettingsViewModel.swift
//  IPCanary
//
//  Created by Seth Butler on 1/18/17.
//  Copyright © 2017 SBSoftware. All rights reserved.
//

import Foundation
import IPCanaryKit

class SettingsViewModel {

    // MARK: - MVVM Variables

    var host: String
    var delegate: ViewModelUpdatable?
    
    // MARK: - Class Variables
    
    private let networkManager: IPCanaryKitNetworkManager

    // MARK: - MVVM Functions
    
    func hostChanged(host: String?) {
        if let newHost = host {
            networkManager.setHost(host: newHost)
        } else {
            networkManager.setHost(host: "")
        }
    }
    
    // MARK: - Class Functions
    
    /// Initializes the ViewModel & prepares data for ViewControllers usage
    ///
    init(networkManager: IPCanaryKitNetworkManager) {
        self.networkManager = networkManager
        self.host = self.networkManager.getHost()
    }
}
