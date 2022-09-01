//
//  CurrencyData.swift
//  Cur-Currency
//
//  Created by Dmytro on 01.09.2022.
//

import Foundation

struct CurrencyData: Decodable {
    var rate: Double
    var asset_id_quote: String
}
