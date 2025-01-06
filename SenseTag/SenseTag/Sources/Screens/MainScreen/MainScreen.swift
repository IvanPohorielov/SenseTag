//
//  MainScreen.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 06.01.2025.
//

import SwiftUI
import CoreUI

struct MainScreen: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Hello, World!")
                }
                .background(Color.red)
            }
        }
    }
}

#Preview {
    MainScreen()
}
