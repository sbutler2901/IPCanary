//
//  IPCanaryUITests.swift
//  IPCanaryUITests
//
//  Created by Seth Butler on 12/15/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import XCTest

class IPCanaryUITests: XCTestCase {
    
    var app: XCUIApplication!
    //var vc: MainViewController!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // Mark: - View Controller Tests
    // FIXME: - fix view Controller tests
    
//    func testMainViewControllerDoesUpdateAuto() {
//        let networkManager = app.
//        let mainViewModel = MainViewModel(networkManager: networkManager)
//        let mainViewController = MainViewController(mainViewModel: mainViewModel)
//        
//        let prevIP = mainViewController.currentIPLabel.text
//        let prevUpdate = mainViewController.ipLastUpdateLabel.text
//        let prevChange = mainViewController.ipLastChangedLabel.text
//        
//        networkManager.delegate = mainViewModel
//        
//        XCTAssertNotNil(networkManager.delegate)
//        
//        let ipAddress = networkManager.currentIPAddress.getIPAddress()
//        let city = networkManager.currentIPAddress.getCity()
//        let country  = networkManager.currentIPAddress.getCountry()
//        let hostname = networkManager.currentIPAddress.getHostname()
//        
//        var newUpdateDate = Date()
//        newUpdateDate.addTimeInterval(TimeInterval(10))
//        
//        networkManager.currentIPAddress.setAddress(address: ipAddress, city: city, country: country, hostname: hostname, date: newUpdateDate)
//        
//        networkManager.delegate?.ipUpdated()
//        
//        XCTAssertEqual(networkManager.currentIPAddress.getIPAddress(), prevIP)
//        XCTAssertEqual(networkManager.currentIPAddress.getLastUpdateDate().description, prevUpdate)
//        XCTAssertEqual(networkManager.currentIPAddress.getLastChangeDate().description, prevChange)
//    }
    
    // MARK: - View Tests
    
    func testDisplayAtLoad() {
        let ipAddressLabel: XCUIElement = app.staticTexts["IP Label"]
        let cityLabel: XCUIElement = app.staticTexts["City Label"]
        let countryLabel: XCUIElement = app.staticTexts["Country Label"]
        let hostnameLabel: XCUIElement = app.staticTexts["Hostname Label"]
        let lastUpdateOutputLabel: XCUIElement = app.staticTexts["Last Update Output Label"]
        let lastChangeOutputLabel: XCUIElement = app.staticTexts["Last Change Output Label"]
        let bottomViewElement: XCUIElement = app.otherElements["Bottom View"]
        //let refreshBtn: XCUIElement = bottomViewElement.buttons["Refresh Button"]
        
        
        XCTAssert(ipAddressLabel.exists)
        XCTAssert(cityLabel.exists)
        XCTAssert(countryLabel.exists)
        XCTAssert(hostnameLabel.exists)
        XCTAssert(lastUpdateOutputLabel.exists)
        XCTAssert(lastChangeOutputLabel.exists)
        XCTAssert(bottomViewElement.exists)
        //XCTAssert(refreshBtn.exists)

        
        bottomViewElement.tap()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
