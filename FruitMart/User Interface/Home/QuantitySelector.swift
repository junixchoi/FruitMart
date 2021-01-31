//
//  QuantitySelector.swift
//  FruitMart
//
//  Created by user on 2021/01/31.
//

import SwiftUI

struct QuantitySelector: View {
  // 상위 뷰가 전달해 준 숫자를 표기하고 변경한 값을 다시 원천 자료와 동기화 할 뿐
  // 값을 직접 소유할 필요가 없으므로 State 대신 Binding을 사용
  @Binding var quantity: Int
  // 수량 선택 가능 범위
  var range: ClosedRange<Int> = 1...20
  
  private let softFeedback = UIImpactFeedbackGenerator(style: .soft)
  private let rigidFeedback = UIImpactFeedbackGenerator(style: .rigid)
  
  var body: some View {
    HStack {
      // 수량 감소 버튼
      Button(action: { self.changeQuantity(-1) }) {
        Image(systemName: "minus.circle.fill")
          .imageScale(.large)
          .padding()
      }
      .foregroundColor(Color.gray.opacity(0.5))
      
      // 현재 수량을 나타낼 텍스트
      Text("\(quantity)")
        .bold()
        .font(Font.system(.title, design: .monospaced)) // monospaced 를 사용하면 숫자가 변해도 일괄된 크기 유지
        .frame(minWidth: 40, maxWidth: 60)
      
      // 수량 증가 버튼
      Button(action: { self.changeQuantity(1) }) {
        Image(systemName: "plus.circle.fill")
          .imageScale(.large)
          .padding()
      }
      .foregroundColor(Color.gray.opacity(0.5))
    }
  }
  
  private func changeQuantity(_ num: Int) {
    // 1~20 내에서 변경되는 경우에만 값에 반영됨
    if range ~= quantity + num {
      quantity += num
      // 진동 지연 시간을 줄일 수 있도록 미리 준비시키는 메서드
      softFeedback.prepare()
      // 지정한 범위 내의 값이면 부드러운 진동으로 처리
      softFeedback.impactOccurred(intensity: 0.8)
    } else {
      rigidFeedback.prepare()
      // 범위를 벗어날 때 강한 진동으로 처리
      rigidFeedback.impactOccurred()
    }
  }
}

struct QuantitySelector_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      QuantitySelector(quantity: .constant(1))
      QuantitySelector(quantity: .constant(10))
      QuantitySelector(quantity: .constant(20))
    }
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
