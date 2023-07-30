//
//  CircleImage.swift
//  Landmarks
//
//  Created by Yunki H on 7/29/23.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("turtlerock")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4.0)
            }
            .shadow(radius: 7)
    }
}

#Preview {
    CircleImage()
}
