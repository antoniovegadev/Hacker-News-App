//
//  HNItemCell.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/12/21.
//

import UIKit

class HNItemCell: UITableViewCell {
    static let reuseID = "HNItemCell"

    let header = UIStackView()
    let rankLabel = HNBodyLabel(fontSize: 12)
    let linkLabel = HNBodyLabel(fontSize: 12)
    let titleLabel = HNTitleLabel(textAlignment: .left, fontSize: 16)
    let footer = UIStackView()
    let upvoteLabel = HNSymbolTextView(symbol: .upArrow)
    let commentLabel = HNSymbolTextView(symbol: .textBubble)
    let dateLabel = HNSymbolTextView(symbol: .clock)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureHeader()
        configureFooter()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(item: Item) {
        rankLabel.text = String(item.rank) + "."
        linkLabel.text = "google.com"
        titleLabel.text = item.title
        upvoteLabel.set(text: String(item.score!))
        commentLabel.set(text: String(item.descendants ?? 0))
        dateLabel.set(text: item.time.relativeStringDate())
    }

    private func configure() {
        addSubview(header)
        addSubview(titleLabel)
        addSubview(footer)
        let padding: CGFloat = 20

        header.translatesAutoresizingMaskIntoConstraints = false
        footer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            header.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            header.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),

            footer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            footer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            footer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14)
        ])
    }

    private func configureHeader() {
        header.axis = .horizontal
        header.spacing = 8

        linkLabel.textColor = .systemOrange
        
        header.addArrangedSubview(rankLabel)
        header.addArrangedSubview(linkLabel)
    }

    private func configureFooter() {
        footer.axis = .horizontal
        footer.spacing = 8

        footer.addArrangedSubview(upvoteLabel)
        footer.addArrangedSubview(commentLabel)
        footer.addArrangedSubview(dateLabel)
    }
}
