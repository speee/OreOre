//
//  UITestBase.swift
//  OreOre_Example
//
//  Created by hayato.iida on 2018/10/23.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import XCTest
import Apollo
import Embassy
import EnvoyAmbassador
import OreOre

internal class UITestBase: XCTestCase {
  let port = 8081
  var eventLoop: EventLoop!
  var server: HTTPServer!
  var app: XCUIApplication!
  lazy var router = GraphQLRouter()

  var eventLoopThreadCondition: NSCondition!
  var eventLoopThread: Thread!

  static var launched = false

  override func setUp() {
    super.setUp()

    continueAfterFailure = true
    if type(of: self).launched == false {
      type(of: self).launched = true
      setupWebApp()
      setupApp()
    }
  }


  private func setupWebApp() {
    eventLoop = try! SelectorEventLoop(selector: try! KqueueSelector()) // swiftlint:disable:this force_try
    server = DefaultHTTPServer(eventLoop: eventLoop, port: port, app: router.app)

    // Start HTTP server to listen on the port
    try? server.start()

    eventLoopThreadCondition = NSCondition()
    eventLoopThread = Thread(target: self, selector: #selector(runEventLoop), object: nil)
    eventLoopThread.start()
  }

  // set up XCUIApplication
  private func setupApp() {
    app = XCUIApplication()
    app.launchEnvironment["BASEURL"] = "http://localhost:\(port)"
  }

  override func tearDown() {
    super.tearDown()
    server?.stopAndWait()
    eventLoopThreadCondition?.lock()
    eventLoop?.stop()
    while eventLoop?.running ?? false {
      if !eventLoopThreadCondition.wait(until: NSDate().addingTimeInterval(10) as Date) {
        fatalError("Join eventLoopThread timeout")
      }
    }
  }

  override class func tearDown() {
    super.tearDown()
    XCUIApplication().terminate()
    launched = false
  }

  @objc
  private func runEventLoop() {
    eventLoop.runForever()
    eventLoopThreadCondition.lock()
    eventLoopThreadCondition.signal()
    eventLoopThreadCondition.unlock()
  }
}
