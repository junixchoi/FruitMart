//
//  Order.swift
//  FruitMart
//
//  Created by user on 2021/02/01.
//

import Foundation

struct Order: Identifiable {
  static var orderSequence = sequence(first: lastOrderId + 1) { $0 &+ 1 }
  static var lastOrderId: Int {
    get { UserDefaults.standard.integer(forKey: "LastOrderID") }
    set { UserDefaults.standard.set(newValue, forKey: "LastOrderID") }
  }
  
  let id: Int
  let product: Product
  let quantity: Int
  
  var price: Int {
    product.price * quantity
  }
}

extension Order: Codable {}
