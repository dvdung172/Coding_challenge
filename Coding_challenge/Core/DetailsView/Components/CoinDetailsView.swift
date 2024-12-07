//
//  CoinDetailsView.swift
//  Coding_challenge
//
//  Created by Dung-pc on 07/12/2024.
//

import UIKit


class CoinDetailsView: UIView {
    private let currentPrice: CoinDetailsItem = {
        let view = CoinDetailsItem()
        return view
    }()
    
    private let marketCapitalization: CoinDetailsItem = {
        let view = CoinDetailsItem()
        return view
    }()
    
    private let rank: CoinDetailsItem = {
        let view = CoinDetailsItem()
        return view
    }()
    
    private let volume: CoinDetailsItem = {
        let view = CoinDetailsItem()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        // Left Column
        let firstRow = UIStackView(arrangedSubviews: [currentPrice, marketCapitalization])
        firstRow.axis = .horizontal
        firstRow.distribution = .fillEqually
        firstRow.alignment = .top
        firstRow.spacing = 16
        
        let secondRow = UIStackView(arrangedSubviews: [rank, volume])
        secondRow.axis = .horizontal
        secondRow.distribution = .fillEqually
        firstRow.alignment = .top
        secondRow.spacing = 16

        
        // Combine Left and Right Columns
        let mainStack = UIStackView(arrangedSubviews: [firstRow, secondRow])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.distribution = .equalSpacing
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainStack)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: - Configure
    func configure(coin: CoinModel) {
        self.currentPrice.configure(label: "Current Price", content: "\(coin.currentPrice)")
        
        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        self.marketCapitalization.configure(label: "Market Capitalization", content: marketCap, additional: coin.marketCapChangePercentage24H)
        self.rank.configure(label: "rank", content: "\(coin.rank)")
        
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        self.volume.configure(label: "volume", content: volume)
    }
}
