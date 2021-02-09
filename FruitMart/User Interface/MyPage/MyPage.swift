//
//  MyPage.swift
//  FruitMart
//
//  Created by user on 2021/02/09.
//

import SwiftUI

struct MyPage: View {
  var body: some View {
    NavigationView {
      Form { // 폼을 이용해 마이페이지 메뉴 그룹화
        orderInfoSection
      }
      .navigationBarTitle("마이페이지")
    }
  }
  
  var orderInfoSection: some View {
    // 섹션을 사용해 이후에 추가될 다른 메뉴와 구분
    Section(header: Text("주문 정보").fontWeight(.medium)) {
      NavigationLink(destination: OrderListView()) { // 목적지 변경
        Text("주문 목록")
      }
      .frame(height: 44) // 높이 지정
    }
  }
}

struct MyPage_Previews: PreviewProvider {
  static var previews: some View {
    MyPage()
  }
}
