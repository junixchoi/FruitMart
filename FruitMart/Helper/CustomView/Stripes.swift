//
//  Stripes.swift
//  FruitMart
//
//  Created by user on 2021/02/09.
//

import SwiftUI

// View 대신 Shape 프로토콜 채택
struct Stripes: Shape, Hashable {
  // 줄무늬가 몇 개로 분할되어 보일 것인지 결정. 기본값 30
  var stripes: Int = 30
  var insertion: Bool = true // 삽입, 제거 효과 구분
  var ratio: CGFloat // 화면 차지 비율 0.0 ~ 1.0
  
  var animatableData: CGFloat {
    get { ratio } // 애니메이션 연산에 ratio 값 활용
    set { ratio = newValue }
  }
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    // 줄무늬 하나가 차지하는 너비 기본값 (전체 너비 / 줄무늬 개수)
    let stripeWidth = rect.width / CGFloat(stripes)
    let rects = (0..<stripes).map { (index: Int) -> CGRect in
      // 줄무늬 시작점 x 좌표
      let xOffset = CGFloat(index) * stripeWidth
      // 삽입될 뷰인지 제거될 뷰인지 구분하여 줄무늬 위치 조정
      let adjustment = insertion ? 0 : (stripeWidth * (1 - ratio))
      return CGRect(
        x: xOffset + adjustment, // 조정값을 더하여 최종 위치 결정
        y: 0,
        width: stripeWidth * ratio, // 줄무늬 너비
        height: rect.height
      )
    }
    path.addRects(rects) // 만들어진 모든 줄무늬를 path에 추가
    return path
  }
}

struct Stripes_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Stripes(insertion: true, ratio: 0.2).previewDisplayName("20%")
      Stripes(insertion: true, ratio: 0.5).previewDisplayName("50%")
      Stripes(insertion: true, ratio: 0.8).previewDisplayName("80%")
      Stripes(insertion: true, ratio: 1.0).previewDisplayName("100%")
      
      Stripes(insertion: false, ratio: 0.8).previewDisplayName("80%")
      Stripes(insertion: false, ratio: 0.5).previewDisplayName("50%")
      Stripes(insertion: false, ratio: 0.2).previewDisplayName("20%")
      Stripes(insertion: false, ratio: 0.0).previewDisplayName("0%")
    }
    .previewLayout(.fixed(width: 350, height: 30))
  }
}
