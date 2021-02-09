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
  @State private var showingFavoriteImage: Bool = true
  
  var body: some View {
    NavigationView {
      VStack {
        if showFavorite {
          favoriteProducts // 구현해 둔 스크롤 뷰에 해당하는 프로퍼티
        }
        darkerDivider
        productList // 기존에 있던 코드를 프로퍼티로 추출
      }
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

private extension Home {
  var favoriteProducts: some View { // 즐겨찾는 상품 목록
    FavoriteProductScrollView(showingImage: $showingFavoriteImage)
      .padding(.top, 24)
      .padding(.bottom, 8)
  }
  
  var darkerDivider: some View { // 커스텀 구분선
    Color.primary
      .opacity(0.3)
      .frame(maxWidth: .infinity, maxHeight: 1)
  }
  
  var productList: some View { // body에 작성되어 있던 기존 코드 추출
    List {
      ForEach(store.products) { product in
        // iOS 13에서 디스클로저 인디케이터를 제거하기 위한 임시 방편이
        // iOS 14에서 동작하지 않으므로 관련 코드 제거
        NavigationLink(destination: ProductDetailView(product: product)) {
          ProductRow(quickOrder: $quickOrder, product: product)
//          NavigationLink(destination: ProductDetailView(product: product)) {
//            EmptyView()
//          }
//          .frame(width: 0)
//          .hidden()
        }
      }
      .listRowBackground(Color.background)
    }
    // iOS 14.0에서는 NavigationView - VStack - List일 때 SidebarListStyle이 기본값
    // iOS 13의 기본값이었던 PlainListStyle로 수정
    .listStyle(PlainListStyle())
    .background(Color.background)
  }
  
  var showFavorite: Bool {
    !store.products.filter({ $0.isFavorite }).isEmpty
      && store.appSetting.showFavoriteList
  }
}
