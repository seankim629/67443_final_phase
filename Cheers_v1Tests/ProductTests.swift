//
//  ProductTests.swift
//  Cheers_v1Tests
//
//  Created by Sooyoung Kim on 2021/12/09.
//

import XCTest
@testable import Cheers_v1

class ProductTests: XCTestCase {

      override func setUp() {
          super.setUp()
      }

      override func tearDown() {
          super.tearDown()
      }

      func testInitialization() {
          let product = Product(name: "Budweiser Beer",fakeName: "Budweiser",
                                      image: "www.exampleimg.com",
                                      avgRating: 4.3,
                                      alc: 2.3,
                                      brewery: "Bud",
                                      style: "Buddyy",
                                      sweet: 3,
                                      sour: 6,
                                      bitter: 8,
                                      fruits: 10)

          XCTAssertNotNil(product)
          XCTAssertEqual(product.name, "Budweiser Beer")
          XCTAssertEqual(product.avgRating, 4.3)
          XCTAssertEqual(product.alc, 2.3)
          XCTAssertEqual(product.style, "Buddyy")
          XCTAssertEqual(product.sour, 6)
          XCTAssertEqual(product.bitter, 8)
          XCTAssertEqual(product.fruits, 10)
      }

}
