//
//  Google_BooksTests.swift
//  Google BooksTests
//
//  Created by Zabeehullah Qayumi on 11/6/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import XCTest

@testable import Google_Books



class Google_BooksTests: XCTestCase {
    
    var sessionUnderTest: URLSession!

    override func setUp() {
        
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)

    }

    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }

    
    func testValidCallToiTunesGetsHTTPStatusCode200() {
        
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=data")
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }

}
