//
//  SelectCurrency.swift
//  SwiftIntro
//
//  Created by Oren Pinkas on 09/04/2025.
//

import SwiftUI

struct CurrencyGrid: View {
    @Environment(\.dismiss) var dismiss
    @Binding var currency: Currency
    
    var body: some View {
        
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(Currency.allCases) { currency in
                if self.currency == currency {
                    CurrencyIcon(coinImage: currency.image, text: currency.name)
                        .shadow(color: .black, radius: 10)
                        .overlay(RoundedRectangle(cornerRadius: 25)
                            .stroke(lineWidth: 3)
                            .opacity(0.5))
                                 } else {
                            CurrencyIcon(coinImage: currency.image, text: currency.name).onTapGesture {
                                self.currency = currency
                            }
                        }
            }
        }
        
    }
}

#Preview {
    @Previewable @State var currency: Currency = .silverPiece
    CurrencyGrid(currency: $currency)
}
