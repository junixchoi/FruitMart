//
//  Popup.swift
//  FruitMart
//
//  Created by user on 2021/02/06.
//

import SwiftUI

enum PopupStyle {
  case none
  case blur
  case dimmed
}

struct Popup<Message: View>: ViewModifier { // ViewModifier 프로토콜 채택
  let size: CGSize? // 팝업창의 크기
  let style: PopupStyle // 앞에서 정의한 팝업 스타일
  let message: Message // 팝업창에 나타낼 메시지
  
  init(
    size: CGSize? = nil,
    style: PopupStyle = .none,
    message: Message
  ) {
    self.size = size
    self.style = style
    self.message = message
  }
  
  func body(content: Content) -> some View {
    content // 팝업창을 띄운 뷰, 팝업창이 나타날 때 배경이 되는 뷰
      .blur(radius: style == .blur ? 2 : 0) // blur 스타일인 경우에만 적용
      .overlay(
        Rectangle() // dimmed 스타일인 경우에만 적용
          .fill(Color.black.opacity(style == .dimmed ? 0.4 : 0))
      )
      .overlay(popupContent) // 팝업창으로 표현될 뷰
  }
  
  private var popupContent: some View {
    GeometryReader { g in
      // message에 2개 이상의 뷰가 포함되어 있으면 세로 방향으로 나열되도록 VStack으로 감싸 주었음
      VStack { self.message } // 팝업창에서 표시할 메시지
        .frame( // 팝업을 만들 때 크기를 지정하지 않으면 뷰 너비의 0.6배, 높이의 0.25배 크기로 설정
          width: self.size?.width ?? g.size.width * 0.6,
          height: self.size?.height ?? g.size.height * 0.25
        )
        .background(Color.primary.colorInvert())
        .cornerRadius(12)
        .shadow(color: .primaryShadow, radius: 15, x: 5, y: 5)
        .overlay(self.checkCircleMark, alignment: .top)
        // iOS 13과 iOS 14의 지오메트리 리더 뷰 정렬 위치가 달라졌으므로 조정
        .position(x: g.size.width / 2, y: g.size.height / 2)
    }
  }
  
  // 팝업창 상단에 위치한 체크 마크 심벌
  private var checkCircleMark: some View {
    Symbol("checkmark.circle.fill", color: .peach)
      .font(Font.system(size: 60).weight(.semibold))
      // iOS 13과 14에서 크기 차이가 있어 조정
      // .background(Color.white.scaleEffect(0.7)) // 체크 마크 배경색을 흰색으로 지정
      .offset(x: 0, y: -20) // 팝업창 상단에 걸쳐지도록 원래 위치보다 위로 가도록 조정
  }
}

// 팝업창이 띄워졌을 때 다른 버튼이 눌리는 것을 방지하고 팝업창을 닫는 역할
fileprivate struct PopupToggle: ViewModifier { // ViewModifier 프로토콜 채택
  @Binding var isPresented: Bool // true 일 때만 팝업창 표현
  
  func body(content: Content) -> some View {
    content
      .disabled(isPresented)
      .onTapGesture {
        self.isPresented.toggle()
      }
  }
}

extension View {
  func popup<Content: View>(
    isPresented: Binding<Bool>,
    size: CGSize? = nil,
    style: PopupStyle = .none,
    @ViewBuilder content: () -> Content
  ) -> some View {
    if isPresented.wrappedValue {
      let popup = Popup(size: size, style: style, message: content())
      let popupToggle = PopupToggle(isPresented: isPresented)
      let modifiedContent = self.modifier(popup).modifier(popupToggle)
      return AnyView(modifiedContent)
    } else {
      return AnyView(self)
    }
  }
}
