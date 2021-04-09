//
//  CoinModel.swift
//  ByteCoin
//
//  Created by MAC on 28/01/2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let time: String
    let coinRate: Double
    let currencyid: String
    
    var rateString: String{
        return String(format: "%.1f", coinRate)
    }
}
