//
//  ProductRow.swift
//  FruitMart
//
//  Created by user on 2020/12/21.
//

import SwiftUI

struct ProductRow: View {
    var body: some View {
        HStack {
            // 상품 이미지
            Image("apple")
                .resizable()
                .scaledToFill()
                .frame(width: 140)
                .clipped()
            
            VStack(alignment: .leading) {
                // 상품명
                Text("백설공주 사과")
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding(.bottom, 6)
                
                // 상품 설명
                Text("달콤한 맛이 좋은 과일의 여왕 사과. 독은 없고 꿀만 가득해요!")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                HStack(spacing: 0) {
                    // 가격 정보와 버튼
                    Text("₩")
                        .font(.footnote) +
                        Text("2100")
                        .font(.headline)
                    
                    Spacer()
                    
                    // 하트 아이콘
                    Image(systemName: "heart")
                        .imageScale(.large)
                        .foregroundColor(Color("peach"))
                        .frame(width: 32, height: 32)
                    
                    // 카트 아이콘
                    Image(systemName: "cart")
                        .foregroundColor(Color("peach"))
                        .frame(width: 32, height: 32)
                }
            }
            .padding([.leading, .bottom], 12)
            .padding([.top, .trailing])
        }
        .frame(height: 150)
        // colorInvert - 색상 반전
        .background(Color.primary.colorInvert())
        // 뷰 모서리 둥글게 처리
        .cornerRadius(6)
        .shadow(color: Color.primary.opacity(0.33), radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow()
    }
}
