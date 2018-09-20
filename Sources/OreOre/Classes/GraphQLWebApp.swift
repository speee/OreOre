//
// Created by hayato.iida on 2018/05/24.
// Copyright (c) 2018 Speee, inc. All rights reserved.
//

import Apollo
import Embassy
import EnvoyAmbassador

public class GraphQLWebApp: WebApp {
  var havingResponseData: HavingResponseData

  init(with responseData: HavingResponseData) {
    self.havingResponseData = responseData
  }

  public func app(_ environ: [String: Any], startResponse: @escaping ((String, [(String, String)]) -> Void), sendBody: @escaping ((Data) -> Void)) {
    havingResponseData.request(header: environ)
    sendBody(havingResponseData.toResponseData)
  }

  func request(parameter: [String: Any]) {
    havingResponseData.request(parameter: parameter)
  }

}

fileprivate extension HavingResponseData {

  var toResponseData: Data {
    let root: JSONObject = [
      "data": self.data
    ]
    return try! JSONSerializationFormat.serialize(value: root)  // swiftlint:disable:this force_try
  }
}

public extension HavingResponseData {
  func request(parameter: [String: Any]) {
  }

  func request(header: [String: Any]) {
  }
}
