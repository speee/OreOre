//
//  SampleOre.swift
//
//  Created by hayato.iida on 2018/06/01.
//  Copyright © 2018年 Speee, inc. All rights reserved.
//

import Foundation
import Apollo
import Fakery
import OreOre

class Ore {
  static var faker: Faker = Faker(locale: "ja")
  static var author = Author()
  static var post = Post()

  final class Author: OreOre {
    var id: GraphQLID = Ore.faker.app.uuid()
    var firstName = Ore.faker.name.firstName()
    var lastName = Ore.faker.name.lastName()
    var posts:[Ore.Post] = []
  }

  final class Post: OreOre {
    var id: GraphQLID = Ore.faker.app.uuid()
  }

}
