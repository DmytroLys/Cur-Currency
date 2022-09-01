//
//  CoinManager.swift
//  Cur-Currency
//
//  Created by Dmytro on 01.09.2022.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateBitcoinLabel(data: CurrencyModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "AD84B39F-F871-4DB2-9700-EF014FC4AE99"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    parseJson(safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyData.self, from: data)
            let currencyData = CurrencyModel(currency: decodedData.asset_id_quote, rate: decodedData.rate)
            delegate?.didUpdateBitcoinLabel(data: currencyData)
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
    
}
