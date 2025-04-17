//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Oren Pinkas on 17/04/2025.
//

import SwiftUI

struct QuoteView: View {
    let vm = ViewModel()
    let show: String

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .frame(
                        width: geo.size.width * 2.7,
                        height: geo.size.height * 1.2)

                VStack {
                    VStack {
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .success:
                            Text("\" \(vm.quote.quote) \"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: vm.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(
                                    width: geo.size.width / 1.1,
                                    height: geo.size.height / 1.8)
                                
                                Text(vm.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(
                                width: geo.size.width / 1.1,
                                height: geo.size.height / 1.8
                            )
                            .clipShape(.rect(cornerRadius: 50))
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }
                        
                        Spacer()
                    }
                    
                    Button("Get Random Quote") {
                        Task {
                            await vm.getData(for: show)
                        }
                    }
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.breakingBadGreen)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(color: .yellow, radius: 2)

                    Spacer(minLength: 95)

                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    let show: String = "Better Call Saul"
    QuoteView(show: show)
        .preferredColorScheme(.dark)
}
