//
//  Currency.swift
//  SwiftIntro
//
//  Created by Oren Pinkas on 10/04/2025.
//

import SwiftUI

enum Currency: Double, CaseIterable, Identifiable {
    var id : Currency { self }
    
    case copperPenny = 6400
    case silverPenny = 64
    case goldPenny = 16
    case silverPiece = 4
    case goldPiece = 1
    case diamondPiece = 0.1
    
    var idString: String {
        switch self {
        case .copperPenny: "copperPenny"
        case .silverPenny: "silverPenny"
        case .goldPenny: "goldPenny"
        case .silverPiece: "silverPiece"
        case .goldPiece: "goldPiece"
        case .diamondPiece: "diamondPiece"
        }
    }
    
    static func from(idString: String) -> Currency? {
        allCases.first { $0.idString == idString }
    }
    
    var image: ImageResource  {
        switch self {
        case .copperPenny: .copperpenny
        case .silverPenny: .silverpenny
        case .goldPenny: .goldpenny
        case .silverPiece: .silverpiece
        case .goldPiece: .goldpiece
        case .diamondPiece: .diamondpiece
        }
    }
    
    var name: String {
        switch self {
        case .copperPenny: "Copper Penny"
        case .silverPenny: "Silver Penny"
        case .goldPenny: "Gold Penny"
        case .silverPiece: "Silver Piece"
        case .goldPiece: "Gold Piece"
        case .diamondPiece: "Diamond Piece"
        }
    }
    
    func convert(_ amountString: String, to currency: Currency) -> String {
        guard let amount = Double(amountString) else {
            return ""
        }
        
        let convertedAmount = amount / self.rawValue * currency.rawValue
        
        return String(convertedAmount)
    }
}
