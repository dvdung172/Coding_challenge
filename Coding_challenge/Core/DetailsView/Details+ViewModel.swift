//
//  Details+ViewModel.swift
//  Coding_challenge
//
//  Created by Dung-pc on 06/12/2024.
//

import Foundation

class DetailsViewModel {
    private(set) var detail: CoinDetailModel?
    private(set) var coin: CoinModel
        
    init(coin: CoinModel) {
        self.coin = coin
    }
    
    func fetchData(onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        CoinDetailDataRepository.shared.getData(id: self.coin.id) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let coin):
                        self?.detail = coin
                        onSuccess()
                    case .failure(let error):
                        print("Error: \(error)")
                        onError()
                    }
                }
            }
        }
}
