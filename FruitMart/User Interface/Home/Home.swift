//
//  ContentView.swift
//  FruitMart
//
//  Created by user on 2020/12/21.
//

import SwiftUI

struct HomeView: View {
    let store: Store
    
    var body: some View {
        List(store.products) { product in
            ProductRow(product: product)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: Store())
    }
}
