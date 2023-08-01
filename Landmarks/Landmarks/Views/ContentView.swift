//
//  ContentView.swift
//  Landmarks
//
//  Created by Yunki H on 7/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

#Preview {
    ContentView()
        .environmentObject(ModelData())
}
