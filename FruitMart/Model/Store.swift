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
  @Published var orders: [Order] = [] {
    didSet { saveData(at: ordersFilePath, data: orders) }
  }
  
  init(filename: String = "ProductData.json") {
    self.products = Bundle.main.decode(filename: filename, as: [Product].self)
    self.orders = loadData(at: ordersFilePath, type: [Order].self)
  }
  
  func placeOrder(product: Product, quantity: Int) {
    let nextId = Order.orderSequence.next()!
    let order = Order(id: nextId, product: product, quantity: quantity)
    orders.append(order)
    print(orders)
    Order.lastOrderId = nextId
  }
  
}

extension Store {
  var ordersFilePath: URL {
    let manager = FileManager.default
    let appSupportDir = manager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    // 번들ID를 서브 디렉토리로 추가
    let bundleID = Bundle.main.bundleIdentifier ?? "FruitMart"
    let appDir = appSupportDir
      .appendingPathComponent(bundleID, isDirectory: true)
    
    // 디렉토리가 없으면 생성
    if !manager.fileExists(atPath: appDir.path) {
      try? manager.createDirectory(at: appDir, withIntermediateDirectories: true)
    }
    
    // 지정한 경로에 파일명 추가 - Orders.json
    return appDir
      .appendingPathComponent("Orders")
      .appendingPathExtension("json")
  }
  
  // 파일 저장
  func saveData<T>(at path: URL, data: T) where T: Encodable {
    do {
      let data = try JSONEncoder().encode(data)
      try data.write(to: path)
    } catch {
      print(error)
    }
  }
  
  // 파일 불러오기
  func loadData<T>(at path: URL, type: [T].Type) -> [T] where T: Decodable {
    do {
      let data = try Data(contentsOf: path)
      let decodedData = try JSONDecoder().decode(type, from: data)
      return decodedData
    } catch {
      return []
    }
  }
  
  func toggleFavorite(of product: Product) {
    guard let index = products.firstIndex(of: product) else { return }
    products[index].isFavorite.toggle()
  }
}
