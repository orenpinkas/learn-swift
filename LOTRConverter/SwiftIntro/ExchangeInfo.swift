//
//  ExchangeInfo.swift
//  SwiftIntro
//
//  Created by Oren Pinkas on 09/04/2025.
//

import SwiftUI

struct ExchangeInfo: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button("Done") {
            dismiss()
        }
        .buttonStyle(.borderedProminent).tint(.brown.mix(with: .black, by: 0.2))
    }
}

#Preview {
    ExchangeInfo()
}
