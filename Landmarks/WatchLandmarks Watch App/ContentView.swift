//
//  ContentView.swift
//  WatchLandmarks Watch App
//
//  Created by Yunki H on 8/5/23.
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
