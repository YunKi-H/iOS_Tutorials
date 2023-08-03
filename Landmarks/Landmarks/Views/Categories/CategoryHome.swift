//
//  CategoryHome.swift
//  Landmarks
//
//  Created by Yunki H on 8/3/23.
//

import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    Text(key)
                }
            }
            .navigationTitle("Featured")
        }
    }
}

#Preview {
    CategoryHome()
        .environmentObject(ModelData())
}
