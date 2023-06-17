//
//  ExchangeRateViewController.swift
//  exchange_rate_demo
//
//  Created by HanhNH11 on 26/05/2023.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var navigationView: UIView!
    
    var viewModel: ExchangeRateViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
    }
}

private extension ExchangeRateViewController {
    
    func setupUI() {
        configTableView()
    }
    
    func setupNavigation() {
        let customNavigationView = XATNavigationView()
        customNavigationView.updatetType(screenType: .exchangeRate)
        customNavigationView.frame = navigationView.bounds
        self.navigationView.addSubview(customNavigationView)
    }
    
    func configTableView() {
        register(name: ExchangeRateTableViewCell.CellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func register(name: String) {
        let nib = UINib(nibName: name, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: name)
    }
    
    func setupData() {
        guard let viewModel = viewModel else { return }
        viewModel.getExchangeRateList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure:
                break
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension ExchangeRateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExchangeRateTableViewCell.CellReuseIdentifier,
            for: indexPath) as? ExchangeRateTableViewCell else {
            
            return UITableViewCell()
        }
        
        guard let exchangeRate = viewModel?.exchangeRateList[indexPath.row] else { return UITableViewCell() }
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setupData(exchangeRate: exchangeRate)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ExchangeRateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
