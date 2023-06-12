//
//  MarketDetailViewController.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 08/06/2023.
//

import UIKit

class MarketDetailViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTitle()
    }
    
    private func updateTitle() {
        self.titleLabel.text = titleString
    }
    
    @IBAction private func closeButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: false)
    }
}
