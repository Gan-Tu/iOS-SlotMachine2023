//
//  ReelView.swift
//  Slot Machine Game 2023
//
//  Created by Gan Tu on 8/12/23.
//

import SwiftUI

struct ReelView: View {
    var body: some View {
        Image("gfx-reel")
            .resizable()
            .modifier(ImageModifier())
    }
}

#Preview {
    ReelView()
}
