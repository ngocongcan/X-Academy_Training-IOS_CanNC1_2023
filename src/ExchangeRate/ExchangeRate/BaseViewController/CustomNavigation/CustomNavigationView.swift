//
//  CustomNavigationView.swift
//  ExchangeRate
//
//  Created by HanhNH11 on 07/06/2023.
//

import Foundation
import UIKit

enum ScreenType: String {
    case exchangeRate = "Ngoại Tệ"
    case goldPrice = "Thị Trường"
}

class CustomNavigationView: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var typeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed(String(describing: CustomNavigationView.self),
                                 owner: self,
                                 options: nil)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
        confirmAvatarImage()
    }
    
    private func confirmAvatarImage() {
        self.avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    func updatetType(screenType: ScreenType) {
        typeLabel.text = screenType.rawValue
    }
}
