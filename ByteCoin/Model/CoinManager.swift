//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "C05B6A5C-BF5F-4AF2-BA85-90CC001E66AE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)?&apikey=\(apiKey)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
        let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
            }
                if let safeData = data {
                    if let coin = self.parseJSON(coinData: safeData){
                       self.delegate?.didUpdateCoin(self, coin: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    
     func parseJSON(coinData: Data) -> CoinModel? {
     let decoder = JSONDecoder()
     do {
 
        let decodedData = try decoder.decode(CoinData.self, from: coinData)
        let time = decodedData.time
        let rate = decodedData.rate
        let currencyid = decodedData.currencyid
        
        print(currencyid)
        print("yoo")

        let bytecoin = CoinModel(time: time, coinRate: rate, currencyid: currencyid)
        return bytecoin
    
     } catch {
         delegate?.didFailWithError(error: error)
         return nil
     }
}
}

