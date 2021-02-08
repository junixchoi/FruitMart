//
//  AnyTransitionExtension.swift
//  FruitMart
//
//  Created by user on 2021/02/09.
//

import SwiftUI

extension AnyTransition {
  static func stripes() -> AnyTransition {
    func stripesModifier(
      stripes: Int = 30,
      insertion: Bool = true,
      ratio: CGFloat
    ) -> some ViewModifier {
      let shape = Stripes(stripes: stripes, insertion: insertion, ratio: ratio)
      return ShapeClipModifier(shape: shape)
    }
    
    let insertion = AnyTransition.modifier(
      active: stripesModifier(ratio: 0),
      identity: stripesModifier(ratio: 1)
    )
    let removal = AnyTransition.modifier(
      active: stripesModifier(insertion: false, ratio: 0),
      identity: stripesModifier(insertion: false, ratio: 1)
    )
    // 뷰가 나타날 때와 사라질 때 각각 다른 효과 적용
    return AnyTransition.asymmetric(
      insertion: insertion,
      removal: removal
    )
  }
}
