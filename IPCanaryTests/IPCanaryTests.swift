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
    
    // Mark: - Model Tests
    
    func testIPAddress() {
        var ipAddress = IPAddress()
        XCTAssertEqual(ipAddress.getIPAddress(), "0.0.0.0")
        XCTAssertEqual(ipAddress.getCity(), "Unknown")
        XCTAssertEqual(ipAddress.getCountry(), "Unknown")
        XCTAssertEqual(ipAddress.getHostname(), "Unknown")
        XCTAssertEqual(ipAddress.getLastChangeDate(), ipAddress.getLastUpdateDate())
        
        var newAddress = "0.0.0.1"
        let city = "Ocean City"
        let country = "United States"
        let hostname = "Hostname"

        ipAddress = IPAddress(address: newAddress, city: city, country: country, hostname: hostname, date: Date())
        XCTAssertEqual(ipAddress.getIPAddress(), newAddress)
        XCTAssertEqual(ipAddress.getCity(), city)
        XCTAssertEqual(ipAddress.getCountry(), country)
        XCTAssertEqual(ipAddress.getHostname(), hostname)
        XCTAssertEqual(ipAddress.getLastChangeDate(), ipAddress.getLastUpdateDate())
        
        newAddress = "0.0.0.2"
        let newDate0 = Date()

        ipAddress = IPAddress(address: newAddress, city: city, country: country, hostname: hostname, date: newDate0)
        XCTAssertEqual(ipAddress.getIPAddress(), newAddress)
        XCTAssertEqual(ipAddress.getCity(), city)
        XCTAssertEqual(ipAddress.getCountry(), country)
        XCTAssertEqual(ipAddress.getHostname(), hostname)
        XCTAssertEqual(ipAddress.getLastChangeDate(), ipAddress.getLastUpdateDate())
        
        // IP change
        newAddress = "0.0.0.3"
        let newDate1 = Date()
        ipAddress.setAddress(address: newAddress, city: city, country: country, hostname: hostname, date: newDate1)
        XCTAssertEqual(ipAddress.getIPAddress(), newAddress)
        XCTAssertEqual(ipAddress.getCity(), city)
        XCTAssertEqual(ipAddress.getCountry(), country)
        XCTAssertEqual(ipAddress.getHostname(), hostname)
        XCTAssertEqual(ipAddress.getLastUpdateDate(), newDate1)
        XCTAssertEqual(ipAddress.getLastUpdateDate(), ipAddress.getLastChangeDate())
        
        // No IP change
        let newDate2 = Date()
        
        ipAddress.setAddress(address: newAddress, city: city, country: country, hostname: hostname, date: newDate2)
        XCTAssertEqual(ipAddress.getIPAddress(), newAddress)
        XCTAssertEqual(ipAddress.getCity(), city)
        XCTAssertEqual(ipAddress.getCountry(), country)
        XCTAssertEqual(ipAddress.getHostname(), hostname)
        XCTAssertEqual(ipAddress.getLastUpdateDate(), newDate2)
        XCTAssertNotEqual(ipAddress.getLastUpdateDate(), ipAddress.getLastChangeDate())
    }
    
    // MARK: - Network Manager Tests
    
    func testNetworkManagerHasIP() {
        XCTAssertNotNil(networkManager.currentIPAddress)
    }
    
    func testNetworkManagerUpdateIP() {
        let previousUpdateDate = networkManager.currentIPAddress.getLastUpdateDate()
        
        let expectation: XCTestExpectation = self.expectation(description: "Network Request")
        
        networkManager.refreshIP() { string in
            XCTAssertNotNil(string, "Expected non-nil string")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssertNotEqual(networkManager.currentIPAddress.getLastUpdateDate(), previousUpdateDate)
    }
    
    func testNetworkManagerParseRequestedData() {
        /*let jsonData: Data = Data("{\"ip\":\"209.222.19.251\",\"ip_decimal\":3520992251,\"country\":\"United States\",\"city\":\"Matawan\",\"hostname\":\"209.222.19.251.adsl.inet-telecom.org\"}")
        networkManager.parseRequestedData(jsonData)*/
        
    }
    
    // MARK: - View Model Tests
    
    func testMainViewModelIP() {
        let mainViewModel = MainViewModel(networkManager: networkManager)
        XCTAssertEqual(mainViewModel.currentIP, networkManager.currentIPAddress.getIPAddress())
        XCTAssertEqual(mainViewModel.ipLastUpdate, networkManager.currentIPAddress.getLastUpdateDate().description)
        XCTAssertEqual(mainViewModel.ipLastChanged, networkManager.currentIPAddress.getLastChangeDate().description)
    }
    
    // Without view model established as delegate
    func testMainViewModelIPUpdated() {
        let mainViewModel = MainViewModel(networkManager: networkManager)
        
        XCTAssertNil(networkManager.delegate)

        let expectation: XCTestExpectation = self.expectation(description: "Network Request")
        
        networkManager.refreshIP() { string in
            XCTAssertNotNil(string, "Expected non-nil string")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertEqual(mainViewModel.ipLastUpdate, networkManager.currentIPAddress.getLastUpdateDate().description)
    }
    
    // With view model established as delegate
    func testMainViewModelRefreshIP() {
        let mainViewModel = MainViewModel(networkManager: networkManager)
        networkManager.delegate = mainViewModel

        let expectation: XCTestExpectation = self.expectation(description: "Network Request")
        
        networkManager.refreshIP() { string in
            XCTAssertNotNil(string, "Expected non-nil string")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssertNotNil(networkManager.delegate)
        XCTAssertEqual(mainViewModel.currentIP, networkManager.currentIPAddress.getIPAddress())
        XCTAssertEqual(mainViewModel.ipLastUpdate, networkManager.currentIPAddress.getLastUpdateDate().description)
        XCTAssertEqual(mainViewModel.ipLastChanged, networkManager.currentIPAddress.getLastChangeDate().description)
    }
    
    // TODO: - After timer refresh has been implemented. Use Mock Data?
    func testMainViewModelExternallyRefreshedIP() {
        let mainViewModel = MainViewModel(networkManager: networkManager)
        networkManager.delegate = mainViewModel
        
        let expectation: XCTestExpectation = self.expectation(description: "Network Request")
        
        networkManager.refreshIP() { string in
            XCTAssertNotNil(string, "Expected non-nil string")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        //XCTAssertNotNil(networkManager.delegate)
        XCTAssertEqual(mainViewModel.currentIP, networkManager.currentIPAddress.getIPAddress())
        XCTAssertEqual(mainViewModel.ipLastUpdate, networkManager.currentIPAddress.getLastUpdateDate().description)
        XCTAssertEqual(mainViewModel.ipLastChanged, networkManager.currentIPAddress.getLastChangeDate().description)
    }
    
    // Mark: - View Controller Tests
    
//    func testMainViewControllerDoesUpdateAuto() {
//        let mainViewModel = MainViewModel(networkManager: networkManager)
//        let mainViewController = MainViewController(mainViewModel: mainViewModel)
//        
//        let prevIP = mainViewController.ipLabel.text
//        let prevUpdate = mainViewController.ipLastUpdateLabel.text
//        let prevChange = mainViewController.ipLastChangeLabel.text
//        networkManager.networkQueryIP()
//        
//        XCTAssertEqual(networkManager.currentIPAddress.getAddress(), prevIP)
//        XCTAssertEqual(networkManager.currentIPAddress.getLastUpdateDate().description, prevUpdate)
//        XCTAssertEqual(networkManager.currentIPAddress.getLastChangeDate().description, prevChange)
//        
//        XCTAssertEqual(networkManager.currentIPAddress.getAddress(), prevIP)
//        XCTAssertEqual(networkManager.currentIPAddress.getLastUpdateDate().description, prevUpdate)
//        XCTAssertEqual(networkManager.currentIPAddress.getLastChangeDate().description, prevChange)    }
    
    // MARK: - Performance tests
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
