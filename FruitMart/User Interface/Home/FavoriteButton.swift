//
//  FavoriteButton.swift
//  FruitMart
//
//  Created by user on 2021/01/31.
//

import SwiftUI

struct FavoriteButton: View {
  @EnvironmentObject private var store: Store
  let product: Product
  
  private var imageName: String {
    product.isFavorite ? "heart.fill" : "heart"
  }
  
  var body: some View {
    Button(action: {
      self.store.toggleFavorite(of: self.product)
    }) {
      Symbol(imageName, scale: .large, color: .peach)
        .frame(width: 32, height: 32)
        .onTapGesture {
          self.store.toggleFavorite(of: self.product)
        }
    }
  }
}

struct FavoriteButton_Previews: PreviewProvider {
  static var previews: some View {
    Group {
          FavoriteButton(product: productSamples[0])
          FavoriteButton(product: productSamples[2])
        }
        .padding()
        .previewLayout(.sizeThatFits)
  }
}
