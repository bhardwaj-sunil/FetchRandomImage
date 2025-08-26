//
//  FetchRandomImageTests.swift
//  FetchRandomImageTests
//
//  Created by Neel Kumar on 24/08/25.
//

import XCTest
@testable import FetchRandomImage

final class FetchRandomImageTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: Integration tests

    // Check API integration test
    func testNetworkFetchRealAPI() async throws {
        let service = NetworkService()
        let items = try await service.fetchRandomItems()
        
        XCTAssertFalse(items.isEmpty, "API should always return some items")
    }
    
    

}
