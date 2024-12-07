//
//  CoinDetailDataRepository.swift
//  Coding_challenge
//
//  Created by Dung-pc on 06/12/2024.
//

import Foundation

protocol CoinDetailDataRepositoryProtocol {
    func getData(id: String, completion: @escaping (Result<CoinDetailModel, APIError>) -> Void)
}

struct CoinDetailDataRepository: CoinDetailDataRepositoryProtocol {
    
    static let shared: CoinDetailDataRepositoryProtocol = CoinDetailDataRepository()
    
    func getData(id: String, completion: @escaping (Result<CoinDetailModel, APIError>) -> Void) {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {
            completion(.failure(.failedToConnectURL))
            return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.requestError))
                return
            }
            
            guard let responseData = data else {
                completion(.failure(.failedToGetData))
                return
            }
            
            // Process the received data
            do {
                let coin = try JSONDecoder().decode(CoinDetailModel.self, from: responseData)
                print("\(response)")
                completion(.success(coin))
            } catch {
                completion(.failure(.failedToConvertData))
            }
        }
        
        dataTask.resume()
    }
}
