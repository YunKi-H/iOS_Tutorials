//
//  ProfileHost.swift
//  Landmarks
//
//  Created by Yunki H on 8/4/23.
//

import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                EditButton()
            }
            
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                ProfileEditor()
            }
        }
        .padding()
    }
}

#Preview {
    ProfileHost()
        .environmentObject(ModelData())
}
