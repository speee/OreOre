//
//  OreOre_ExampleUITests.swift
//  OreOre_ExampleUITests
//
//  Created by hayato.iida on 2018/09/26.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import XCTest
import Nimble


class OreOre_ExampleUITests: UITestBase {

  override func setUp() {
    // setup router before super.setUp()
    router.append(AuthorQuery(id: 0).operationDefinition, Responses.Author())
    super.setUp()

  }

  func testExample() {
    let author = Ore.author["1"]
    expect(self.app.staticTexts[author.firstName].exists).to(beTrue())
    expect(self.app.staticTexts[author.lastName].exists).to(beTrue())
  }

}
