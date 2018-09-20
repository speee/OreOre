//
// Created by hayato.iida on 2018/05/18.
// Copyright (c) 2018 Speee, inc. All rights reserved.
//

import Apollo
import Embassy
import EnvoyAmbassador

open class GraphQLRouter: Router {
  var graphQLRoutes: [String: GraphQLWebApp] = [:]

  override open func app(
      _ environ: [String: Any],
      startResponse: @escaping ((String, [(String, String)]) -> Void),
      sendBody: @escaping ((Data) -> Void)
  ) {
    guard let input = environ["swsgi.input"] as? SWSGIInput else {
      startResponse("200 OK", [("Content-Type", "application/json")])
      sendBody(Data())
      return
    }

    startResponse("200 OK", [("Content-Type", "application/json")])

    JSONReader.read(input) { json in
      if let requestParams = json as? [String: Any] {
        if let query = requestParams["query"] as? String {
          if let webApp = self.graphQLRoutes.first(where: {
            (key: String, value: GraphQLWebApp) in
            return query.contains(key)
          })?.value {
            if let variables = requestParams["variables"] as? [String: Any] {
              webApp.request(parameter: variables)
            }
            webApp.app(environ, startResponse: startResponse, sendBody: sendBody)
            sendBody(Data())
            return
          }
        }
      }
      return self.notFoundResponse.app(environ, startResponse: startResponse, sendBody: sendBody)
    }
  }
}

extension GraphQLRouter {
  public func append(_ key: String, _ value: HavingResponseData) {
    self.graphQLRoutes[key] = GraphQLWebApp(with: value)
  }
}
