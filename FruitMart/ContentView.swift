//
//  ContentView.swift
//  FruitMart
//
//  Created by user on 2020/12/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ProductRow()
            ProductRow()
            ProductRow()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
