//
//  LogoView.swift
//  Slot Machine Game 2023
//
//  Created by Gan Tu on 8/12/23.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("gfx-slot-machine")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 256, idealWidth: 300, maxWidth: 320, minHeight: 112, idealHeight: 130, maxHeight: 140, alignment: .center)
            .padding(.horizontal)
            .modifier(ShadowModifier())
    }
}

#Preview {
    LogoView()
}
