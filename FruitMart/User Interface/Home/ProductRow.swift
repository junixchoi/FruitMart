//
//  ProductRow.swift
//  FruitMart
//
//  Created by user on 2020/12/21.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack {
            productImage
            productDescription
        }
        .frame(height: 150)
        // colorInvert - 색상 반전
        .background(Color.primary.colorInvert())
        // 뷰 모서리 둥글게 처리
        .cornerRadius(6)
        .shadow(color: Color.primaryShadow, radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
    }
}

private extension ProductRow {
    var productImage: some View {
        // 상품 이미지
        Image(product.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 140)
            .clipped()
    }

    var productDescription: some View {
        VStack(alignment: .leading) {
            // 상품명
            Text(product.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)
            
            // 상품 설명
            Text(product.description)
                .font(.footnote)
                .foregroundColor(Color.secondaryText)
            
            Spacer()
            
            footerView
        }
        .padding([.leading, .bottom], 12)
        .padding([.top, .trailing])
    }

    var footerView: some View {
        HStack(spacing: 0) {
            // 가격 정보와 버튼
            Text("₩")
                .font(.footnote) +
                Text("\(product.price)")
                .font(.headline)
            
            Spacer()
            
            // 하트 아이콘
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundColor(Color.peach)
                .frame(width: 32, height: 32)
            
            // 카트 아이콘
            Image(systemName: "cart")
                .foregroundColor(Color.peach)
                .frame(width: 32, height: 32)
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: productSamples[0])
    }
}