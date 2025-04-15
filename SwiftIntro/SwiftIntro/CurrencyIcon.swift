//
//  SelectCurrency.swift
//  SwiftIntro
//
//  Created by Oren Pinkas on 09/04/2025.
//

import SwiftUI

struct CurrencyIcon: View {
    let coinImage: ImageResource
    let text: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(coinImage)
                .resizable()
                .scaledToFit()
            
            Text(text)
                .padding(3)
                .font(.caption)
                .frame(maxWidth: .infinity)
                .background(.brown.opacity(0.75))
            
        }
        .padding(3)
        .frame(width: 100, height: 100)
        .background(.brown)
        .clipShape(.rect(cornerRadius: 25))
    }
}

#Preview {
    CurrencyIcon(coinImage: .copperpenny, text: "Copper Penny")
}
