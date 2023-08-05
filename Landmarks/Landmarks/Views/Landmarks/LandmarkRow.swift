//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by Yunki H on 7/31/23.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark
    
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(5)
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .bold()
                #if !os(watchOS)
                Text(landmark.park)
                    .font(.caption)
                    .foregroundColor(.secondary)
                #endif
            }
            
            Spacer()
            
            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    var landmarks = ModelData().landmarks
    
    return Group {
        LandmarkRow(landmark: landmarks[0])
        LandmarkRow(landmark: landmarks[1])
    }
    .previewLayout(.fixed(width: 300, height: 70))
}
