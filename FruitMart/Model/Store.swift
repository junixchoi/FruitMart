//
//  Store.swift
//  FruitMart
//
//  Created by user on 2020/12/21.
//

import Foundation

final class Store: ObservableObject {
  @Published var products: [Product]
  
  // 전체 주문 목록
  @Published var orders: [Order] = []
  
  init(filename: String = "ProductData.json") {
    self.products = Bundle.main.decode(filename: filename, as: [Product].self)
  }
  
  func placeOrder(product: Product, quantity: Int) {
    let nextId = Order.orderSequence.next()!
    let order = Order(id: nextId, product: product, quantity: quantity)
    orders.append(order)
    print(orders)
  }
  
}

extension Store {
  func toggleFavorite(of product: Product) {
    guard let index = products.firstIndex(of: product) else { return }
    products[index].isFavorite.toggle()
  }
}
