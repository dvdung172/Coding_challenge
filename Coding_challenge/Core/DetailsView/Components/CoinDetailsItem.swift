//
//  CoinDetailsItem.swift
//  Coding_challenge
//
//  Created by Dung-pc on 07/12/2024.
//

import UIKit

class CoinDetailsItem: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.createLabel()
        return label
    }()
    
    private let content: UILabel = {
        let label = UILabel()
        label.createLabel(font: .boldSystemFont(ofSize: 18), textColor: .black)
        return label
    }()
    
    private let additional: UILabel = {
        let label = UILabel()
        label.createLabel()
        return label
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
        let viewStack = UIStackView(arrangedSubviews: [label, content, additional])
        viewStack.axis = .vertical
        viewStack.spacing = 4
        viewStack.alignment = .top
        viewStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(viewStack)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            viewStack.topAnchor.constraint(equalTo: topAnchor),
            viewStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    // MARK: - Configure
    func configure(label: String, content: String, additional: Double? = nil) {
        self.label.text = label
        self.content.text = content
        if let additional = additional {
            self.additional.text = "\(additional)%"
            self.additional.textColor = additional > 0 ? .green : .red
            
        }
    }
}
