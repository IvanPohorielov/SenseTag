//
//  RecordContainerView.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 23.03.2025.
//

import SwiftUI
import FoundationUI

struct RecordContainerView<Content: View>: View {

    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        HStack(spacing: .spacer8) {
            self.content
        }
        .padding(.spacer16)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(
            .rect(cornerRadius: .radius8)
        )
        .contentShape(
            .rect(cornerRadius: .radius8)
        )
    }
}

#Preview {
    RecordContainerView {
        Text("Test")
    }
}
