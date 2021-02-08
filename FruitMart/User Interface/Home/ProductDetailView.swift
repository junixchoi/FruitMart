//
//  ProductDetailView.swift
//  FruitMart
//
//  Created by user on 2020/12/21.
//

import SwiftUI

struct ProductDetailView: View {
  let product: Product // 상품 정보를 전달받기 위한 프로퍼티 선언
  @State private var showingAlert: Bool = false
  @State private var quantity: Int = 1
  @State private var showingPopup: Bool = false
  @EnvironmentObject private var store: Store
  @State private var willAppear: Bool = false
  
  var body: some View {
    VStack(spacing: 0) {
      if willAppear {
        productImage // 상품 이미지
      }
      orderView // 상품 정보를 출력하고 그 상품을 주문하기 위한 뷰
    }
    // .modifier(Popup(style: .blur, message: Text("팝업")))
    // 팝업 크기 지정 및 dimmed 스타일 적용
    //.modifier(Popup(size: CGSize(width: 200, height: 200), style: .dimmed, message: Text("팝업")))
    .popup(isPresented: $showingPopup) { OrderCompletedMessage() }
    .edgesIgnoringSafeArea(.top)
    .alert(isPresented: $showingAlert) { confirmAlert }
    // 화면이 나타나는 시점에 productImage가 뷰 계층 구조에 추가되도록 구현
    .onAppear { self.willAppear = true }
  }
}

extension ProductDetailView {
  var productImage: some View {
    let effect = AnyTransition.scale.combined(with: .opacity)
      .animation(Animation.easeInOut(duration: 0.4).delay(0.05))
    return GeometryReader { _ in
      ResizedImage(self.product.imageName)
    }
    .transition(effect)
  }
  
  // 상품 설명과 주문하기 버튼 등을 모두 포함하는 컨테이너
  var orderView: some View {
    GeometryReader {
      VStack(alignment: .leading) {
        self.productDescription // 상품명과 즐겨찾기 버튼(하트) 이미지
        Spacer()
        self.priceInfo // 가격 정보
        self.placeOrderButton // 주문하기 버튼
      }
      .padding(32)
      // geometry reader가 차지하는 뷰의 높이보다 VStack의 높이가 10만큼 크도록 지정
      .frame(height: $0.size.height + 10)
      .background(Color.white) // 다크모드에서 흰색 배경을 사용하기 위해 white 지정
      .cornerRadius(16)
      .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
    }
  }
  
  var productDescription: some View {
    VStack(alignment: .leading, spacing: 16) {
      HStack {
        // 상품명
        Text(product.name)
          .font(.largeTitle)
          .fontWeight(.medium)
          .foregroundColor(.black)
        
        Spacer()
        
        // 즐겨찾기 버튼
        FavoriteButton(product: product)
      }
      
      Text(splitText(product.description))
        .foregroundColor(.secondaryText)
        .fixedSize() // 뷰의 크기가 작아져도 텍스트가 생략되지 않고 온전히 표현
    }
  }
  
  var priceInfo: some View {
    // 수량 * 상품 가격
    let price = quantity * product.price
    return HStack {
      (Text("₩")
        + Text("\(price)")
        .font(.title)
      )
      .fontWeight(.medium)
      Spacer()
      // 수량 선택 버튼이 들어갈 위치
      QuantitySelector(quantity: $quantity)
    }
    // 배경을 다크 모드에서 항상 흰색이 되게 지정해 텍스트도 항상 검은색이 되게 지정
    .foregroundColor(.black)
  }
  
  // 주문하기 버튼
  var placeOrderButton: some View {
    Button(action: {
      self.showingAlert = true
    }) {
      Capsule()
        .fill(Color.peach)
        // 너비는 주어진 공간을 최대로 사용하고 높이는 최소, 최대치 지정
        .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
        .overlay(
          Text("주문하기")
            .font(.system(size: 20))
            .fontWeight(.medium)
            .foregroundColor(Color.white)
        )
        .padding(.vertical, 8)
    }
    .buttonStyle(ShrinkButtonStyle()) // 커스텀 버튼 스타일 적용
  }
  
  var confirmAlert: Alert {
    Alert(title: Text("주문 확인"),
          message: Text("\(product.name)을(를) \(quantity)개 구매하겠습니까?"),
          primaryButton: .default(Text("확인"), action: {
            // 주문 기능
            self.placeOrder()
          }), secondaryButton: .cancel(Text("취소")))
  }
  
  // 상품과 수량 정보를 placeOrder 메서드에 인수로 전달
  func placeOrder() {
    store.placeOrder(product: product, quantity: quantity)
    showingPopup = true
  }
  
  // 한 문장으로 길게 구성한 상품 설명 문장을, 화면에 좀 더 적절하게 나타내기 위해 두 줄로 나누어주는 함수
  func splitText(_ text: String) -> String {
    guard !text.isEmpty else { return text }
    let centerIdx = text.index(text.startIndex, offsetBy: text.count / 2)
    let centerSpaceIdx = text[..<centerIdx].lastIndex(of: " ")
      ?? text[centerIdx...].firstIndex(of: " ")
      ?? text.index(before: text.endIndex)
    let afterSpaceIdx = text.index(after: centerSpaceIdx)
    let lhsString = text[..<afterSpaceIdx].trimmingCharacters(in: .whitespaces)
    let rhsString = text[afterSpaceIdx...].trimmingCharacters(in: .whitespaces)
    return String(lhsString + "\n" + rhsString)
  }
}

struct ProductDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let source1 = ProductDetailView(product: productSamples[0])
    let source2 = ProductDetailView(product: productSamples[1])
    
    return Group {
      // 나머지 매개 변수 생략 시 총 4가지 환경에서의 프리뷰 출력
      Preview(source: source1)
      // iPhone 11 Pro + 라이트 모드 - 1가지 환경에서만 출력
      Preview(source: source2, devices:  [.iPhone11Pro], displayDarkMode: false)
    }
  }
}

