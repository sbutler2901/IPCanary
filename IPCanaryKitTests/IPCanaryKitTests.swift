//
//  IPCanaryKitTests.swift
//  IPCanaryKitTests
//
//  Created by Seth Butler on 12/30/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import XCTest
@testable import IPCanaryKit

class IPCanaryKitTests: XCTestCase {
    
    var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkManager = NetworkManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - IPAddress Tests
    
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
        
        ipAddress = IPAddress(address: newAddress, city: city, country: country, hostname: hostname)
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
    
    // Ensures network manager's current ip has been initialized
    func testNetworkManagerHasIP() {
        XCTAssertNotNil(networkManager.currentIPAddress)
    }
    
    // Ensures when the network manager makes a new network request, the current IP has been updated
    func testNetworkManagerUpdateIP() {
        let previousUpdateDate = networkManager.currentIPAddress.getLastUpdateDate()
        
        //let expectation: XCTestExpectation = self.expectation(description: "Network Request")
        
        networkManager.refreshIP()
        
        //waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssertNotEqual(networkManager.currentIPAddress.getLastUpdateDate(), previousUpdateDate)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - Notification Manager Tests

}
