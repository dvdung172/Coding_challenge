//
//  CoinDataRepository.swift
//  Coding_challenge
//
//  Created by Dung-pc on 05/12/2024.
//

import Foundation

protocol CoinDataRepositoryProtocol {
    func getData(page: Int, limit: Int, completion: @escaping (Result<[CoinModel], APIError>) -> Void)
}

struct CoinDataRepository: CoinDataRepositoryProtocol {
    
    static let shared: CoinDataRepository = CoinDataRepository()
    
    func getData(page: Int, limit: Int, completion: @escaping (Result<[CoinModel], APIError>) -> Void) {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=\(limit)&page=\(page)&sparkline=true&price_change_percentage=24h") else {
            completion(.failure(.failedToConnectURL))
            return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(.failure(.requestError))
                return
            }
            
            guard let responseData = data else {
                completion(.failure(.failedToGetData))
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([CoinModel].self, from: responseData)
                completion(.success(coins))
            } catch {
                print(response)
                completion(.failure(.failedToConvertData))
            }
        }
        
        dataTask.resume()
    }
}
