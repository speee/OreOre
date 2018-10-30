//
//  ApolloClient.swift
//  OreOre_Example
//
//  Created by hayato.iida on 2018/10/30.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import Apollo

let apollo = apolloClientInitializer()

internal var isTesting: Bool {
  let isUITest = ProcessInfo.processInfo.arguments.contains("UITest")
  return isUITest
}

private let apolloClientInitializer = { () -> ApolloClient in

  let url: URL
  let webSocketURL = URL(string: "wss://mvp-mock-server-xbtneumzxo.now.sh/subscriptions")!  // swiftlint:disable:this force_unwrapping

  let testURL = "http://localhost:8081/graphql"
  let prodURL = "http://localhost:8080/graphql"
  if isTesting {
    url = URL(string: testURL)!
  } else {
    url = URL(string: prodURL)!
  }

  return ApolloClient(url: url)
}
