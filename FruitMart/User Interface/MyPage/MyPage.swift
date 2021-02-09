//
//  MyPage.swift
//  FruitMart
//
//  Created by user on 2021/02/09.
//

import SwiftUI

struct MyPage: View {
  @EnvironmentObject var store: Store // 앱 설정에 접근하기 위해
  private let pickerDataSource: [CGFloat] = [140, 150, 160] // 피커 선택지
  
  var body: some View {
    NavigationView {
      Form { // 폼을 이용해 마이페이지 메뉴 그룹화
        orderInfoSection
        appSettingSection
      }
      .navigationBarTitle("마이페이지")
    }
  }
  
  var appSettingSection: some View {
    Section(header: Text("앱 설정").fontWeight(.medium)) {
      Toggle("즐겨찾는 상품 표시", isOn: $store.appSetting.showFavoriteList)
        .frame(height: 44)
      productHeightPicker
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
  
  var productHeightPicker: some View {
    VStack(alignment: .leading) {
      Text("상품 이미지 높이 조절") // 피커의 제목 역할을 대신 수행
      
      // 피커에서 선택한 값을 appSetting의 productRowHeight와 연동
      Picker("상품 이미지 높이 조절", selection: $store.appSetting.productRowHeight) {
        ForEach(pickerDataSource, id: \.self) {
          Text(String(format: "%.0f", $0)).tag($0) // 포맷을 이용해 소수점 제거
        }
      }
      .pickerStyle(SegmentedPickerStyle()) // 피커 스타일 변경
    }
    .frame(height: 72) // 텍스트가 추가되어 높이를 44 -> 72로 변경
  }
}

struct MyPage_Previews: PreviewProvider {
  static var previews: some View {
    MyPage()
  }
}
