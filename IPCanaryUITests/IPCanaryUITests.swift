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
    
    func testDisplayAtLoad() {
        let refreshBtn = app.buttons["Refresh Button"]
        let lastUpdateOutputLabel = app.staticTexts["Last Update Output Label"]
        let lastChangeOutputLabel = app.staticTexts["Last Change Output Label"]
        
        XCTAssert(refreshBtn.exists)
        XCTAssert(lastUpdateOutputLabel.exists)
        XCTAssert(lastChangeOutputLabel.exists)
        
        
        refreshBtn.tap()
        //XCTAssertEqual(lastUpdateOutputLabel.val, lastChangeOutputLabel.value)
        
        
        //app.staticTexts["IP Label"].tap()
        //app.staticTexts["Last Change Label"].tap()
        //app.staticTexts["Last Update Label"].tap()

    
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
