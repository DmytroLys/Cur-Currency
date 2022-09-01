//
//  CurrencyModel.swift
//  Cur-Currency
//
//  Created by Dmytro on 01.09.2022.
//

import Foundation

struct CurrencyModel {
    
    var currency:String
    var rate: Double
    
    var rateToString:String {
        return String(format: "%.2f", rate)
    }
}
