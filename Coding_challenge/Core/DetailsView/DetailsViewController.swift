//
//  DetailViewController.swift
//  Coding_challenge
//
//  Created by Dung-pc on 04/12/2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private var viewModel: DetailsViewModel
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let loadingView: CircleLoadingView = {
        let loadingView = CircleLoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Read more...", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let coinDetailsView: CoinDetailsView = {
        let view = CoinDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(coin: CoinModel) {
        self.viewModel = DetailsViewModel(coin: coin)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = ""
        
        //setup tableView
        setupView()
        
        loadingView.startLoading()
        viewModel.fetchData(
            onSuccess: { [weak self] in
                guard let self = self else { return }
                loadData()
                loadingView.stopLoading()
            },
            onError: { [weak self] in
                guard let self = self else { return }
                loadingView.stopLoading()
                showAlert()
            })
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setupContentView()
        view.addSubview(loadingView)

        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupContentView() {
        //        contentView.addSubview(overviewLabel)
        
        let overview = UIStackView(arrangedSubviews: [overviewLabel, iconImageView])
        overview.axis = .horizontal
        overview.spacing = 16
        overview.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(overview)
        
        contentView.addSubview(separator)
        contentView.addSubview(descriptionLabel)
        //button
        descriptionButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        contentView.addSubview(descriptionButton)
        //
        contentView.addSubview(coinDetailsView)
        
        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            overview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            overview.heightAnchor.constraint(equalToConstant: 25),
            
            separator.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 16),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            separator.heightAnchor.constraint(equalToConstant: 0.2),
            
            descriptionLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            descriptionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            descriptionButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
            
            coinDetailsView.topAnchor.constraint(equalTo: descriptionButton.topAnchor, constant: 12),
            coinDetailsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coinDetailsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
        ])
    }
    
    private func loadData() {
        descriptionLabel.text = viewModel.detail?.description?.en
        overviewLabel.text = viewModel.coin.name
        coinDetailsView.configure(coin: viewModel.coin)
        iconImageView.loadImage(urlString: viewModel.coin.image)
        
    }
    
    @objc func pressed() {
        if self.descriptionLabel.numberOfLines == 0 {
            self.descriptionButton.setTitle("Read more...", for: .normal)
            UIView.animate(withDuration: 0.3, animations: {
                self.descriptionLabel.numberOfLines = 5
                self.view.layoutIfNeeded()
            })
            return
        }
        self.descriptionButton.setTitle("Show less", for: .normal)
        UIView.animate(withDuration: 0.3, animations: {
            self.descriptionLabel.numberOfLines = 0
            self.view.layoutIfNeeded()
        })
    }
}
