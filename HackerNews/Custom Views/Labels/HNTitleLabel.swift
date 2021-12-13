//
//  HNTitleLabel.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/12/21.
//

import UIKit

class HNTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }

    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = false
        numberOfLines = 0
        lineBreakStrategy = .standard
        translatesAutoresizingMaskIntoConstraints = false
    }

}
