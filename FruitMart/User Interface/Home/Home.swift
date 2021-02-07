//
//  ContentView.swift
//  FruitMart
//
//  Created by user on 2020/12/21.
//

import SwiftUI

struct Home: View {
  @EnvironmentObject private var store: Store
  @State private var quickOrder: Product? // 빠른 주문 기능으로 주문한 상품 저장
  
  var body: some View {
    NavigationView {
      List(store.products) { product in
        NavigationLink(destination: ProductDetailView(product: product)) {
          ProductRow(quickOrder: self.$quickOrder, product: product)
        }
        .buttonStyle(PlainButtonStyle())
      }
      .navigationBarTitle("과일 마트")
    }
    .popupOverContext(item: $quickOrder, style: .blur, content: popupMessage(product:))
  }
  
  func popupMessage(product: Product) -> some View {
    let name = product.name.split(separator: " ").last! // 상품명에서 마지막 단어 추출
    return VStack {
      Text(name)
        .font(.title)
        .bold()
        .kerning(3)
        .foregroundColor(.peach)
        .padding()
      
      OrderCompletedMessage() // 기존에 만들었던 뷰를 재활용
    }
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Preview(source: Home())
      .environmentObject(Store())
  }
}
