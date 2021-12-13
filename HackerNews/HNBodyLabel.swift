//
//  HNBodyLabel.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/12/21.
//

import UIKit

class HNBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    private func configure() {
        textColor = .label
        textAlignment = .left
        adjustsFontSizeToFitWidth = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
