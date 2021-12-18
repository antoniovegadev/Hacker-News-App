//
//  HNTableHeader.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/15/21.
//

import UIKit

class HNTableHeader: UIView {

    let vStack = UIStackView()
    let titleLabel = HNTitleLabel(textAlignment: .left, fontSize: 16)
    let linkButton = HNButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        configureVStack()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(item: Item) {
        self.init(frame: .zero)

        titleLabel.text = item.title
        linkButton.set(title: item.url?.strippedURL() ?? "google.com")
    }

    private func configure() {
        addSubview(vStack)
    }

    private func configureVStack() {
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.spacing = 5

        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(linkButton)
    }

    private func layoutUI() {
        vStack.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
    }
}
