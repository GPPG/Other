//
//  MoyaTests.swift
//  CameraTests
//
//  Created by HuangMingXi-G on 2019/5/20.
//

import XCTest
@testable import Moya

class MoyaTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSmmsUpload() {
        let e = XCTestExpectation.init(description: "moya")
        let image = #imageLiteral(resourceName: "testUpload")
//        SMMSProvider.request(.upload(image)) { (result) in
//            e.fulfill()
//        }
        wait(for: [e], timeout: 20)
    }
}
