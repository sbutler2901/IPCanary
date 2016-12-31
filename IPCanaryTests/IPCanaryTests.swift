//
//  IPCanaryTests.swift
//  IPCanaryTests
//
//  Created by Seth Butler on 12/15/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import XCTest
@testable import IPCanary

class IPCanaryTests: XCTestCase {
    //var vc : MainViewController!
    var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        networkManager = NetworkManager()
        
        /*let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateInitialViewController() as! MainViewController*/
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // TODO: - Ensure tests cover all public interfaces
    
    // MARK: - MainViewModel Tests
    // FIXME: - Dup tests to handle when mock data has same IP & when IP changes?
    
    // Ensures instance of mainview model's ip variables matches that of network manager's
    func testMainViewModelIP() {
        let mainViewModel = MainViewModel(networkManager: networkManager)
        XCTAssertEqual(mainViewModel.currentIP, networkManager.currentIPAddress.getIPAddress())
        XCTAssertEqual(mainViewModel.city, networkManager.currentIPAddress.getCity())
        XCTAssertEqual(mainViewModel.country, networkManager.currentIPAddress.getCountry())
        XCTAssertEqual(mainViewModel.hostname, networkManager.currentIPAddress.getHostname())
        XCTAssertEqual(mainViewModel.ipLastUpdate, networkManager.currentIPAddress.getLastUpdateDate().description)
        XCTAssertEqual(mainViewModel.ipLastChanged, networkManager.currentIPAddress.getLastChangeDate().description)
    }
    
    // Tests if main view model IP is updated without the view model being established as delegate
    func testMainViewModelIPUpdated() {
        let mainViewModel = MainViewModel(networkManager: networkManager)
        
        XCTAssertNil(networkManager.delegate)
        
        let ipAddress = networkManager.currentIPAddress.getIPAddress()
        let city = networkManager.currentIPAddress.getCity()
        let country  = networkManager.currentIPAddress.getCountry()
        let hostname = networkManager.currentIPAddress.getHostname()
        
        var newUpdateDate = Date()
        newUpdateDate.addTimeInterval(TimeInterval(10))
        
        networkManager.currentIPAddress.setAddress(address: ipAddress, city: city, country: country, hostname: hostname, date: newUpdateDate)
        networkManager.delegate?.ipUpdated()
        
        XCTAssertNotEqual(mainViewModel.ipLastUpdate, networkManager.currentIPAddress.getLastUpdateDate().description)
    }
    
    // Tests if main view model IP is updated with view model established as delegate
    func testMainViewModelRefreshIP() {
        let mainViewModel = MainViewModel(networkManager: networkManager)
        networkManager.delegate = mainViewModel
        
        XCTAssertNotNil(networkManager.delegate)
        
        let ipAddress = networkManager.currentIPAddress.getIPAddress()
        let city = networkManager.currentIPAddress.getCity()
        let country  = networkManager.currentIPAddress.getCountry()
        let hostname = networkManager.currentIPAddress.getHostname()
        
        var newUpdateDate = Date()
        newUpdateDate.addTimeInterval(TimeInterval(10))
        
        networkManager.currentIPAddress.setAddress(address: ipAddress, city: city, country: country, hostname: hostname, date: newUpdateDate)
        
        networkManager.delegate?.ipUpdated()
        
        XCTAssertEqual(mainViewModel.currentIP, networkManager.currentIPAddress.getIPAddress())
        XCTAssertEqual(mainViewModel.ipLastUpdate, networkManager.currentIPAddress.getLastUpdateDate().description)
        XCTAssertEqual(mainViewModel.ipLastChanged, networkManager.currentIPAddress.getLastChangeDate().description)
    }
    
    // TODO: - After timer refresh has been implemented. Use Mock Data?
    
    // Mock data code:
    
//        let mockDataString: String = "{\"ip\":\"209.222.19.251\",\"ip_decimal\":3520992251,\"country\":\"United States\",\"city\":\"Matawan\",\"hostname\":\"209.222.19.251.adsl.inet-telecom.org\"}"
//        self.parseRequestedData(data: mockDataString.data(using: .utf8)!)
//        self.delegate?.ipUpdated()
//        completionHandler?("SUCCESS")
    
    // End Mock data
    
//    func testMainViewModelExternallyRefreshedIP() {
//        let mainViewModel = MainViewModel(networkManager: networkManager)
//        networkManager.delegate = mainViewModel
//        
////        let expectation: XCTestExpectation = self.expectation(description: "Network Request")
////        
////        networkManager.refreshIP() { statusCode in
////            // Must unwrap the optional string before testing
////            if let statusCodeUnwrapped = statusCode {
////                //print("Test: \(stringUnwrapped)")
////                XCTAssertEqual(statusCodeUnwrapped, "SUCCESS")
////                //XCTAssertNotNil(statusCodeUnwrapped, "Expected non-nil string")
////                expectation.fulfill()
////            } else {
////                XCTFail()
////            }
////        }
////        
////        waitForExpectations(timeout: 10.0, handler: nil)
//        
//        //XCTAssertNotNil(networkManager.delegate)
//        XCTAssertEqual(mainViewModel.currentIP, networkManager.currentIPAddress.getIPAddress())
//        XCTAssertEqual(mainViewModel.ipLastUpdate, networkManager.currentIPAddress.getLastUpdateDate().description)
//        XCTAssertEqual(mainViewModel.ipLastChanged, networkManager.currentIPAddress.getLastChangeDate().description)
//    }

    // MARK: - Performance tests
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
