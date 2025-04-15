//
//  ContentView.swift
//  SwiftIntro
//
//  Created by Oren Pinkas on 01/04/2025.
//

import SwiftUI
import TipKit
import Foundation

struct ContentView: View {
    @State var showExchangeInfo: Bool = false
    @State var showSelectCurrency: Bool = false
    
    @State var sourceAmount: String = ""
    @State var targetAmount: String = ""

    @FocusState var sourceTyping
    @FocusState var targetTyping
    
    @State var sourceCurrency: Currency
    @State var targetCurrency: Currency
    
    let currencyTip = CurrencyTip()
    
    init() {
        let stored = UserDefaults.standard.dictionary(forKey: "selectedCurrency") as? [String: String] ?? [:]
        let sourceCurrency = Currency.from(idString: stored["source"] ?? "") ?? .silverPiece
        let targetCurrency = Currency.from(idString: stored["target"] ?? "") ?? .goldPiece
        _sourceCurrency = State(initialValue: sourceCurrency)
        _targetCurrency = State(initialValue: targetCurrency)
    }
    
    var body: some View {
        ZStack{
            
            Image(.background).resizable().ignoresSafeArea()
            
            VStack {
                
                Image(.prancingpony).resizable().scaledToFit().frame(height: 200)
                
                Text("Currency Exchange").font(.largeTitle).foregroundStyle(.white)
                
                HStack {
                    VStack {
                        HStack {
                            Image(sourceCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            Text(sourceCurrency.name)
                                .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                            
                        }
                        .onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        .popoverTip(currencyTip, arrowEdge: .bottom)
                        
                        TextField("Amount", text:$sourceAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($sourceTyping)

                    }
                    .padding()
                    
                    Image(systemName: "equal").foregroundStyle(.white).font(.largeTitle).symbolEffect(.pulse)
                    
                    VStack{
                        HStack {
                            Image(targetCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            Text(targetCurrency.name)
                                .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                            
                        }
                        .onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        TextField("Amount", text:$targetAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($targetTyping)

                    }.padding()
                }
                .background(.black.opacity(0.5)).clipShape(.capsule).keyboardType(.decimalPad)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button (action:{
                        showExchangeInfo.toggle()
                    } ,label:{
                        Image(systemName: "info.circle.fill").font(.largeTitle).foregroundStyle(.white)
                    })
                    .padding()
                    

                }
                
                
            }
            .border(.blue)
        }
        .task {
            try? Tips.configure()
        }
        .onTapGesture {
            sourceTyping = false
            targetTyping = false
        }
        .onChange(of: targetAmount) {
            if targetTyping {
                sourceAmount = targetCurrency.convert(targetAmount, to: sourceCurrency)
            }
        }
        .onChange(of: sourceAmount) {
            if sourceTyping {
                targetAmount = sourceCurrency.convert(sourceAmount, to: targetCurrency)
            }
        }
        .onChange(of: sourceCurrency) {
            targetAmount = sourceCurrency.convert(sourceAmount, to: targetCurrency)
            UserDefaults.standard.set(["source": sourceCurrency.idString, "target": targetCurrency.idString], forKey: "selectedCurrency")
        }
        .onChange(of: targetCurrency) {
            sourceAmount = targetCurrency.convert(targetAmount, to: sourceCurrency)
            UserDefaults.standard.set(["source": sourceCurrency.idString, "target": targetCurrency.idString], forKey: "selectedCurrency")
        }
        .sheet(isPresented: $showExchangeInfo, content: {
            ExchangeInfo()
        })
        .sheet(isPresented: $showSelectCurrency, content: {
            SelectCurrency(sourceCurrency: $sourceCurrency, targetCurrency: $targetCurrency)
        })
    }
}

#Preview {
    ContentView()
}
