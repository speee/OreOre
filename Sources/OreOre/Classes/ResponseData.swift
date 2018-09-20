//
// Created by hayato.iida on 2018/05/24.
// Copyright (c) 2018 Speee, inc. All rights reserved.
//

import Apollo
import Embassy
import EnvoyAmbassador

public typealias QueryResponse = HavingResponseData & HavingAnySelectionSet

public protocol HavingResponseData {
  var data: JSONEncodable { get }
  func request(parameter: [String: Any])
  func request(header: [String: Any])
}

public protocol HavingAnySelectionSet {
  associatedtype DataSet: GraphQLSelectionSet

  var response: DataSet { get }
}

extension HavingAnySelectionSet where Self: HavingResponseData {
  public var data: JSONEncodable {
    return self.response.resultMap
  }
}

extension GraphQLSelectionSet {
  public init(with hasResultMap: HavingResultMap) {
    self.init(unsafeResultMap: hasResultMap.resultMap)
  }
}
