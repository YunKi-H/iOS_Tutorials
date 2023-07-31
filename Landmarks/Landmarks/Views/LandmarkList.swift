//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Yunki H on 8/1/23.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        List(landmarks) { landmark in
            LandmarkRow(landmark: landmark)
        }
        .listStyle(.plain)
    }
}

#Preview {
    LandmarkList()
}
