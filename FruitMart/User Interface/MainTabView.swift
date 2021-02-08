//
//  MainTabView.swift
//  FruitMart
//
//  Created by user on 2021/02/08.
//

import SwiftUI

struct MainTabView: View {
  private enum Tabs {
    case home, recipe, gallery, myPage // 4개의 탭 정의. 탭 뷰의 태그로 활용
  }
  
  @State private var selectedTab: Tabs = .home // 기본값 home
  
  var body: some View {
    TabView(selection: $selectedTab) {
      Group {
        home
        recipe
        imageGallery
        myPage
      }
      .accentColor(.primary) // 실제 콘텐츠에서 다시 primary로 변경
    }
    .accentColor(.peach) // 탭 뷰에 peach 적용
    .edgesIgnoringSafeArea(.top)
    // selectedTab의 값이 recipe인 경우에만 상태 표시줄 숨김 처리
    .statusBar(hidden: selectedTab == .recipe)
  }
}

private extension MainTabView {
  var home: some View {
    Home()
      .tag(Tabs.home)
      .tabItem(image: "house", text: "홈")
      // iOS 14.0에서는 이 방식이 적용되지 않습니다.
      .onAppear { UITableView.appearance().separatorStyle = .none }
  }
  
  var recipe: some View {
    RecipeView()
      .tag(Tabs.recipe)
      .tabItem(image: "book", text: "레시피")
  }
  
  var imageGallery: some View {
    Text("이미지 갤러리")
      .tag(Tabs.gallery)
      .tabItem(image: "photo.on.rectangle", text: "갤러리")
  }
  
  var myPage: some View {
    Text("마이페이지")
      .tag(Tabs.myPage)
      .tabItem(image: "person", text: "마이페이지")
  }
}

fileprivate extension View {
  func tabItem(image: String, text: String) -> some View {
    self.tabItem {
      Symbol(image, scale: .large)
        .font(Font.system(size: 17, weight: .light))
      Text(text)
    }
  }
}
