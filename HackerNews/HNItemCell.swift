//
//  HNItemCell.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/12/21.
//

import UIKit

class HNItemCell: UITableViewCell {
    static let reuseID = "HNItemCell"

    let titleLabel = HNTitleLabel(textAlignment: .left, fontSize: 16)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(item: Item) {
        titleLabel.text = item.title
    }

    private func configure() {
        addSubview(titleLabel)
        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
