//
//  FruitCard.swift
//  FruitMart
//
//  Created by user on 2021/02/09.
//

import SwiftUI

struct FruitCard: View {
  let imageName: String
  let size: CGSize
  let cornerRadius: CGFloat
  
  init(
    _ imageName: String, // 필수값
    size: CGSize = CGSize(width: 240, height: 200),
    cornerRadius: CGFloat = 14
  ) {
    self.imageName = imageName
    self.size = size
    self.cornerRadius = cornerRadius
  }
  
  var body: some View {
    ResizedImage(imageName)
      .frame(width: size.width, height: size.height)
      .cornerRadius(cornerRadius)
  }
}

struct FruitCard_Previews: PreviewProvider {
  static var previews: some View {
    ForEach(productSamples) {
      FruitCard($0.imageName)
        .previewLayout(.fixed(width: 260, height: 220))
    }
  }
}
