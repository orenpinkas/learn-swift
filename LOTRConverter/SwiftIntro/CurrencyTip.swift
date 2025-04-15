//
//  CurrencyTip.swift
//  SwiftIntro
//
//  Created by Oren Pinkas on 11/04/2025.
//

import TipKit

struct CurrencyTip: Tip {
    var title = Text("Change Currency")
    var message: Text? = Text("bla bla bla. bla bla bla. bla bla blah.")
    var image: Image? = Image(systemName: "hand.tap.fill")
}
