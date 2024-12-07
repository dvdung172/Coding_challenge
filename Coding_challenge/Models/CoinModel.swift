//
//  CoinModel.swift
//  Coding_challenge
//
//  Created by Dung-pc on 05/12/2024.
//


import Foundation


struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank: Double?
    let totalVolume: Double?
    let priceChangePercentage24H: Double?
    let marketCapChangePercentage24H: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"     
        case marketCapRank = "market_cap_rank"
        case marketCap = "market_cap"
        case totalVolume = "total_volume"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}
