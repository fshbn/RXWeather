//
//  CurrentWeatherTest.swift
//  Weather
//
//  Created by Boran ASLAN on 14/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Weather

class CurrentWeatherTest: XCTestCase {
    
    let weatherService: ServiceProtocol = OpenWeatherMapService()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAPIwithValidLocation() {
        let location = CLLocation(latitude: 40.9911260, longitude: 29.1070620)
        
        weatherService.getWeatherInfo(location) { weather, error -> Void in
            XCTAssertEqual(weather?.cityId, 821)
        }
    }
    
    func testAPIwithInvalidLocation() {
        let location = CLLocation(latitude: 12345, longitude: 29.1070620)

        weatherService.getWeatherInfo(location) { weather, error -> Void in
            XCTAssertEqual(weather?.cityId, 0)
        }
    }
    
}
