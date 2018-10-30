//
//  File.swift
//
//  Created by hayato.iida on 2018/05/27.
//  Copyright © 2018年 Speee, inc. All rights reserved.
//

import Apollo
import Embassy
import EnvoyAmbassador
import OreOre

public struct Responses {
  static var shared = Responses()

  struct Author: QueryResponse {
    typealias DataSet = AuthorQuery.Data

    typealias Item = DataSet.Author


    var response: DataSet {
      let author = Item.init(with:Ore.author["1"])

      return DataSet.init(author: author)
    }

  }
}
