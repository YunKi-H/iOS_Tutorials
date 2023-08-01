//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Yunki H on 8/1/23.
//

import SwiftUI

struct LandmarkList: View {
    @State private var showFavoritesOnly = true
    
    var filteredLandmarks: [Landmark] {
        landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredLandmarks) { landmark in
                NavigationLink {
                    LandmarkDetail(landmark: landmark)
                } label: {
                    LandmarkRow(landmark: landmark)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Landmarks")
        }
    }
}

#Preview {
    LandmarkList()
}
