//
//  HNSymbolTextView.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/12/21.
//

import UIKit

class HNSymbolTextView: UIView {

    let symbol = UIImageView()
    let label = HNBodyLabel(fontSize: 12)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }

    convenience init(symbol: HNSymbols) {
        self.init(frame: .zero)
        self.symbol.image = UIImage(systemName: symbol.rawValue)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(text: String) {
        label.text = text
    }

    private func configure() {
        addSubview(symbol)
        addSubview(label)
        configureImageView()
        configureLabel()
    }

    private func configureImageView() {
        symbol.tintColor = .label
        symbol.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureLabel() {
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    private func layoutUI() {
        NSLayoutConstraint.activate([
            symbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            symbol.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbol.heightAnchor.constraint(equalToConstant: 14),
            symbol.widthAnchor.constraint(equalToConstant: 14),

            label.centerYAnchor.constraint(equalTo: symbol.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: symbol.trailingAnchor, constant: 1),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
}
