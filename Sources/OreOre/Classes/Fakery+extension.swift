//
// Created by hayato.iida on 2018/06/07.
// Copyright (c) 2018 Speee, inc. All rights reserved.
//

import Foundation
import Fakery

extension Fakery.App {
  func uuid() -> String {
    return NSUUID().uuidString
  }
}

extension Fakery.Number {
  func now() -> Int {
    return Int(Date().timeIntervalSince1970)
  }

  func minutes(ago: Double) -> Int {
    return Int(Date().addingTimeInterval(-60 * ago).timeIntervalSince1970)
  }

  func hours(ago: Double) -> Int {
    return Int(Date().addingTimeInterval(-60 * 60 * ago).timeIntervalSince1970)
  }
}
