//
//  Main+ViewModel.swift
//  Coding_challenge
//
//  Created by Dung-pc on 04/12/2024.
//

import Foundation

class MainViewModel {
    private(set) var cryptos: [CoinModel] = []
    private(set) var page = 1
    
    func fetchData(onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        CoinDataRepository.shared.getData(page: page, limit: 100) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cryptos):
                    self?.cryptos.append(contentsOf: cryptos)
                    self?.page += 1
                    onSuccess()
                case .failure(let error):
                    print("Error: \(error)")
                    onError()
                }
            }
        }
    }
    
    func resetData() {
        cryptos = []
        page = 1
    }
}
