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

    let hStack = UIStackView()
    let upvoteLabel = HNSymbolTextView(symbol: .upArrow)
    let author = HNSymbolTextView(symbol: .person)
    let dateLabel = HNSymbolTextView(symbol: .clock)

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        configureHStack()
        configureVStack()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(item: Item) {
        self.init(frame: .zero)

        titleLabel.text = item.title
        linkButton.set(title: item.urlString?.strippedURL() ?? "google.com")
        upvoteLabel.set(text: String(item.score!))
        author.set(text: item.author)
        dateLabel.set(text: item.dateCreated.relativeStringDate())
    }

    private func configure() {
        addSubview(vStack)
    }

    private func configureVStack() {
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.spacing = 10

        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(linkButton)
        vStack.addArrangedSubview(hStack)
    }

    private func configureHStack() {
        hStack.axis = .horizontal
        hStack.spacing = 8

        hStack.addArrangedSubview(upvoteLabel)
        hStack.addArrangedSubview(author)
        hStack.addArrangedSubview(dateLabel)
    }

    private func layoutUI() {
        vStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.translatesAutoresizingMaskIntoConstraints = false
        let horizontalPadding: CGFloat = 15
        let verticalPadding: CGFloat = 10

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalPadding),
            vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding),
            vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalPadding),

            hStack.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}
