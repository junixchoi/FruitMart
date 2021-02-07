//
//  ProductRow.swift
//  FruitMart
//
//  Created by user on 2020/12/21.
//

import SwiftUI

struct ProductRow: View {
  @EnvironmentObject var store: Store
  @Binding var quickOrder: Product?
  
  let product: Product
  
  var body: some View {
    HStack {
      productImage
      productDescription
    }
    .frame(height: 150)
    // colorInvert - 색상 반전
    .background(Color.primary.colorInvert())
    // 뷰 모서리 둥글게 처리
    .cornerRadius(6)
    .shadow(color: Color.primaryShadow, radius: 1, x: 2, y: 2)
    .padding(.vertical, 8)
  }
}

private extension ProductRow {
  var productImage: some View {
    // 상품 이미지
    Image(product.imageName)
      .resizable()
      .scaledToFill()
      .frame(width: 140)
      .clipped()
  }
  
  var productDescription: some View {
    VStack(alignment: .leading) {
      // 상품명
      Text(product.name)
        .font(.headline)
        .fontWeight(.medium)
        .padding(.bottom, 6)
      
      // 상품 설명
      Text(product.description)
        .font(.footnote)
        .foregroundColor(Color.secondaryText)
      
      Spacer()
      
      footerView
    }
    .padding([.leading, .bottom], 12)
    .padding([.top, .trailing])
  }
  
  var footerView: some View {
    HStack(spacing: 0) {
      // 가격 정보와 버튼
      Text("₩")
        .font(.footnote) +
        Text("\(product.price)")
        .font(.headline)
      
      Spacer()
      
      // 하트 아이콘
      FavoriteButton(product: product)
      // 카트 아이콘
      Image(systemName: "cart")
        .foregroundColor(Color.peach)
        .frame(width: 32, height: 32)
      
      Symbol("cart", color: .peach)
        .frame(width: 32, height: 32)
        .onTapGesture {
          self.orderProduct() // 빠른 주문 기능 수행
        }
    }
  }
  
  func orderProduct() {
    quickOrder = product // 주문 상품 저장, 팝업창 출력 조건
    store.placeOrder(product: product, quantity: 1) // 상품 1개 주문
  }
}

struct ProductRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ForEach(productSamples) {
        ProductRow(quickOrder: .constant(nil), product: $0)
      }
      ProductRow(quickOrder: .constant(nil), product: productSamples[0])
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/) // 다크 모드 설정
    }
    .padding() // sizeThatFits를 이용하여 보더라도 약간의 여백을 주도록 추가
    .previewLayout(.sizeThatFits) // 콘텐츠 크기에 맞춰서 프리뷰 컨테이너 크기 조정
  }
}
