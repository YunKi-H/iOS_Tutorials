//
//  CategoryItem.swift
//  Landmarks
//
//  Created by Yunki H on 8/3/23.
//

import SwiftUI

struct CategoryItem: View {
    var landmark: Landmark
    
    var body: some View {
        VStack(alignment: .leading) {
            landmark.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            Text(landmark.name)
                .foregroundColor(.primary)
                .font(.caption)
//                .foregroundStyle(.primary)
        }
        .padding(.leading, 15)
    }
}

#Preview {
    CategoryItem(landmark: ModelData().landmarks[0])
}
