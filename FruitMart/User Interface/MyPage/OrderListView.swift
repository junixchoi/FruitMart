//
//  OrderListView.swift
//  FruitMart
//
//  Created by user on 2021/02/09.
//

import SwiftUI

struct OrderListView: View {
  @EnvironmentObject var store: Store // 주문 정보를 다루려고 추가
  var body: some View {
    ZStack {
      if store.orders.isEmpty {
        emptyOrders
      } else {
        orderList
      }
    }
    .animation(.default)
    .navigationBarTitle("주문 목록")
  }
  
  var orderList: some View {
    List {
      ForEach(store.orders) {
        OrderRow(order: $0)
      }
    }
  }
  
  var emptyOrders: some View {
    VStack(spacing: 25) {
      Image("box") // 애셋에 포함된 박스 이미지
        .renderingMode(.template) // 본래 이미지의 색을 무시하고 다음 줄에 작성한 Color.gray.opacity(0.4) 를 적용
        .foregroundColor(Color.gray.opacity(0.4))
      
      Text("주문 내역이 없습니다.")
        .font(.headline)
        .fontWeight(.medium)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.background)
  }
}

struct OrderListView_Previews: PreviewProvider {
  static var previews: some View {
    OrderListView()
  }
}
