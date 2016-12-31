//
//  IPCanaryWidgetViewModel.swift
//  IPCanaryWidget
//
//  Created by Seth Butler on 12/28/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import Foundation
import IPCanaryKit

protocol ViewModelUpdatable: class {
    func viewModelDidUpdate()
}

class IPCanaryWidgetViewModel {
    var currentIP: String
    var city: String
    var country: String
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
        ipLastUpdate = networkManager.getCurrentIPAddress().getLastUpdateDate().description
        ipLastChanged = networkManager.getCurrentIPAddress().getLastChangeDate().description
    }
}
