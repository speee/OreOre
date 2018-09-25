//
//  OreOre.swift
//
//  Created by hayato.iida on 2018/06/01.
//  Copyright © 2018年 Speee, inc. All rights reserved.
//

import Foundation
import Apollo

public typealias OreOre = BaseOre & FakeSubscript & HavingResultMap & Encodable

// swiftlint:disable identifier_name force_try
open class BaseOre {
  public var __model: [String: Any] = [:]

  public init() {}
}

public protocol FakeSubscript: HavingGraphQLId {
  var id:      GraphQLID { get set }
  var __model: [String: Any] { get set }

  init()
  init(with id: GraphQLID)
}

public extension FakeSubscript {
  public subscript(id: String) -> Self {
    mutating get {
      guard let model = self.__model[id] as? Self else {
        let new = Self.init(with: id)
        self.__model[id] = new
        return new
      }
      return model
    }
    set(item) {
      self.__model[id] = item
    }
  }
}

public extension FakeSubscript {
  public init(with id: GraphQLID) {
    self.init()
    self.id = id
  }
}

public protocol HavingResultMap {
  func reflectEncode() -> ResultMap
  var resultMap: ResultMap { get }
}

public protocol HavingGraphQLId {
  var id: GraphQLID { get }
}

public extension Array where Element: HavingResultMap {
  public var resultMap: [ResultMap] {
    return self.map { $0.resultMap }
  }
}

public extension HavingResultMap where Self: Encodable {
  public var resultMap: ResultMap {
    return reflectEncode()
  }

  func reflectEncode() -> ResultMap {
    var dict: ResultMap = [:]
    Mirror(reflecting: self).children.forEach { child in
      guard let label = child.label else {
        return
      }
      dict[label] = encodeSingle(value: child.value) 
    }
    if dict["__typename"] == nil {
      dict["__typename"] = String(describing: type(of: self))
    }
    return dict
  }

  func encodeSingle(value: Any) -> Any {
    if let result = value as? String {
      return result
    } else if let result = value as? Int {
      return result
    } else if let result = value as? Float {
      return result
    } else if let result = value as? Double {
      return result
    } else if let result = value as? Bool {
      return result
    } else if let result = value as? Array<Any> {
      if result.isEmpty {
        let dummy: [JSONEncodable] = []
        return dummy
      } else {
        return result.map { encodeSingle(value: $0) }
      }
    } else if let result = value as? Dictionary<String, Any> {
      return encodeSingle(value: result)
    } else if let result = value as? HavingResultMap {
      return result.reflectEncode()
    } else {
      return NSNull()
    }
  }
}

extension NSNull: JSONEncodable {
  public var jsonValue: JSONValue {
    return self
  }
}
