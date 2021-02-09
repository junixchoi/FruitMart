//
//  OrderRow.swift
//  FruitMart
//
//  Created by user on 2021/02/09.
//

import SwiftUI

struct OrderRow: View {
  let order: Order // 주문 정보
  var body: some View {
    HStack {
      ResizedImage(order.product.imageName) // 상품 이미지
        .frame(width: 60, height: 60)
        .clipShape(Circle())
        .padding()
      
      VStack(alignment: .leading, spacing: 10) {
        Text(order.product.name) // 상품명
          .font(.headline)
          .fontWeight(.medium)
        
        Text("\(order.price) | \(order.quantity) 개")
          .font(.footnote)
          .foregroundColor(.secondary)
      }
    }
    .frame(height: 100)
  }
}
