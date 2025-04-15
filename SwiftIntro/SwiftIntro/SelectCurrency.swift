//
//  SelectCurrency.swift
//  SwiftIntro
//
//  Created by Oren Pinkas on 09/04/2025.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @Binding var sourceCurrency: Currency
    @Binding var targetCurrency: Currency
    
    var body: some View {
        ZStack {
            Image(.parchment).resizable().ignoresSafeArea().background(.brown)
            
            VStack {
                Text("Select the currency you are starting with:").fontWeight(.medium)
                CurrencyGrid(currency: $sourceCurrency)
                
                Text("Select the currency you would like to convert to:").fontWeight(.medium)
                CurrencyGrid(currency: $targetCurrency)
                
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent).tint(.brown.mix(with: .black, by: 0.2))
                .padding()
                .font(.largeTitle)
                
                
            }.multilineTextAlignment(.center).padding()
            
        }
    }
}

#Preview {
    @Previewable @State var sourceCurrency: Currency = .silverPiece
    @Previewable @State var targetCurrency: Currency = .goldPiece
    SelectCurrency(sourceCurrency: $sourceCurrency, targetCurrency: $targetCurrency)
}
