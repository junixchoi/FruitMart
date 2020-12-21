//
//  ContentView.swift
//  FruitMart
//
//  Created by user on 2020/12/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            ProductRow(product: productSamples[0])
            ProductRow(product: productSamples[1])
            ProductRow(product: productSamples[2])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
