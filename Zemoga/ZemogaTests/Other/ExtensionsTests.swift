//
//  ExtensionsTests.swift
//  ZemogaTests
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//  Copyright © 2019 Eduardo Oliveros Acosta. All rights reserved.
//

import XCTest
@testable import Zemoga

class ExtensionsTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        let width = 40
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 40))
        view.circularLayout()
        
        XCTAssertEqual(view.layer.cornerRadius, CGFloat(width/2), "cornerRadius should be width/2")
        XCTAssertTrue(view.clipsToBounds, "clipsToBounds should be true")
        XCTAssertTrue(view.layer.masksToBounds, "clipsToBounds should be true")
        XCTAssertFalse(view.layer.isOpaque, "isOpaque should be false")
    }
}
