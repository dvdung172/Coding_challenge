//
//  CircleLoadingView.swift
//  Coding_challenge
//
//  Created by Dung-pc on 07/12/2024.
//
import UIKit

class CircleLoadingView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .white // Customize the color
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Semi-transparent background
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(backgroundView)
        backgroundView.addSubview(activityIndicator)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            // Background View
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: 80),
            backgroundView.heightAnchor.constraint(equalToConstant: 80),
            
            // Activity Indicator
            activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
    }
    
    func startLoading() {
        isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        isHidden = true
        activityIndicator.stopAnimating()
    }
}
