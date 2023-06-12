//
//  MarketViewController.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 07/06/2023.
//

import UIKit

class MarketViewController: UIViewController {
    
    @IBOutlet private weak var navigationView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: MarketViewModel?
    private let activityIndicatorView = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigation()
        addSubviewActivityIndicator()
    }
}

private extension MarketViewController {
    func setupNavigation() {
        let customNavigationView = CustomNavigationView()
        customNavigationView.updatetType(screenType: .goldPrice)
        customNavigationView.frame = navigationView.bounds
        navigationView.addSubview(customNavigationView)
    }
    
    func configTableView() {
        register(name: "MarketTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func register(name: String) {
        let nib = UINib(nibName: name, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: name)
    }
    
    func setupUI() {
        configTableView()
    }
    
    func setupData() {
        loadingStatusDidChange()
        getGoldExchangeRateList()
    }
    
    func addSubviewActivityIndicator() {
        activityIndicatorView.center = view.center
        view.addSubview(activityIndicatorView)
    }
    
    func getGoldExchangeRateList() {
        guard let viewModel = viewModel else { return }
        
        viewModel.getGoldExchangeRateList { [weak self] result in
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
    
    func loadingStatusDidChange() {
        guard let viewModel = viewModel else { return }
        viewModel.loadingStatusDidChange = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicatorView.startAnimating()
                } else {
                    self?.activityIndicatorView.stopAnimating()
                }
            }
        }
    }
    
    func presentViewController(titleString: String) {
        let viewController = MarketDetailViewController()
        viewController.titleString = titleString
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: false)
    }
}

extension MarketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketTableViewCell", for: indexPath) as? MarketTableViewCell,
              let city = viewModel?.cities[indexPath.row] else { return UITableViewCell() }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setupData(city: city)
        return cell
    }
}

extension MarketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = viewModel?.cities[indexPath.row],
              let titleString = city.items.first?.type else { return }
        presentViewController(titleString: titleString)
    }
}
