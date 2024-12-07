//
//  MainViewController.swift
//  Coding_challenge
//
//  Created by Dung-pc on 04/12/2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private let tableView = UITableView()
    private var viewModel: MainViewModel
    
    private let loadingView: CircleLoadingView = {
        let loadingView = CircleLoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    init() {
        self.viewModel = MainViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //setup NavigationBar
        setupNavigationBar()
        
        //setup tableView
        setupTableView()
        
        //        //fetchData
        fetchData()
        
    }
    
    private func fetchData() {
        loadingView.startLoading()
        viewModel.fetchData (
            onSuccess:{
                self.loadingView.stopLoading()
                self.tableView.reloadData()
            },
            onError: { [weak self] in
                guard let self = self else { return }
                showAlert()
                self.loadingView.stopLoading()
            })
    }
    private func showAlert() {
        let alert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
            self.viewModel.resetData()
            self.tableView.reloadData()
            self.fetchData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupNavigationBar() {
        title = "Home"
        navigationItem.backButtonTitle = ""
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CryptoCell.self, forCellReuseIdentifier: CryptoCell.identifier)
        
        view.addSubview(tableView)
        view.addSubview(loadingView)
        
        
        // Constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cryptos.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView()
        
        //set background color
        let backgroundView = UIView(frame: header.bounds)
        backgroundView.backgroundColor = .white
        header.backgroundView = backgroundView
        
        // set items
        let coinLabel = UILabel()
        coinLabel.text = "Coin"
        coinLabel.createLabel()
        
        let priceLabel = UILabel()
        priceLabel.text = "Price"
        priceLabel.createLabel()
        
        header.contentView.addSubview(coinLabel)
        header.contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            coinLabel.leadingAnchor.constraint(equalTo: header.contentView.leadingAnchor, constant: 16),
            coinLabel.centerYAnchor.constraint(equalTo: header.contentView.centerYAnchor),
            
            priceLabel.trailingAnchor.constraint(equalTo: header.contentView.trailingAnchor, constant: -16),
            priceLabel.centerYAnchor.constraint(equalTo: header.contentView.centerYAnchor)
        ])
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCell.identifier, for: indexPath) as? CryptoCell else {
            return UITableViewCell()
        }
        let crypto = viewModel.cryptos[indexPath.row]
        cell.configure(with: crypto)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsVC = DetailsViewController(coin: viewModel.cryptos[indexPath.row])
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = viewModel.cryptos.count - 1
        if indexPath.row == lastIndex {
            fetchData()
        }
    }
}
