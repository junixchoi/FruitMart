//
//  Store.swift
//  FruitMart
//
//  Created by user on 2020/12/21.
//

import Foundation

final class Store {
    var products: [Product]

    init(filename: String = "ProductData.json") {
      self.products = Bundle.main.decode(filename: filename, as: [Product].self)
    }
}
