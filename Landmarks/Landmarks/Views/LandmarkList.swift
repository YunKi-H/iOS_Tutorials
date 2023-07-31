//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Yunki H on 8/1/23.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        NavigationView {
            List(landmarks) { landmark in
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
