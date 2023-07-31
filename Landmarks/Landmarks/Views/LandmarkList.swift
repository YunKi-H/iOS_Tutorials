//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Yunki H on 8/1/23.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        VStack {
            List {
                LandmarkRow(landmark: landmarks[0])
                LandmarkRow(landmark: landmarks[1])
            }
            .listStyle(.insetGrouped)
            List {
                LandmarkRow(landmark: landmarks[0])
                LandmarkRow(landmark: landmarks[1])
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    LandmarkList()
}
