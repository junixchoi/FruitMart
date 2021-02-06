//
//  OrderCompletedMessage.swift
//  FruitMart
//
//  Created by user on 2021/02/06.
//

import SwiftUI

struct OrderCompletedMessage: View {
  var body: some View {
    Text("주문 완료!")
      .font(.system(size: 24))
      .bold() // 볼드체
      .kerning(2) // 자간 조정
  }
}

struct OrderCompletedMessage_Previews: PreviewProvider {
  static var previews: some View {
    OrderCompletedMessage()
  }
}
