//
//  ContentView.swift
//  FruitMart
//
//  Created by user on 2020/12/21.
//

import SwiftUI

struct Home: View {
  @EnvironmentObject private var store: Store
  
  var body: some View {
    
    NavigationView {
      List(store.products) { product in
        NavigationLink(destination: ProductDetailView(product: product)) {
          ProductRow(product: product)
        }
        .buttonStyle(PlainButtonStyle())
      }
      .navigationBarTitle("과일 마트")
    }
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Preview(source: Home())
      .environmentObject(Store())
  }
}
