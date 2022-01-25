//
//  HNCommentCell.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/18/21.
//

import UIKit

class HNCommentCell: UITableViewCell {

    static let reuseID = "HNCommentCell"

    let authorButton = HNButton()
    let dateLabel = HNBodyLabel(fontSize: 12)
    let commentTextLabel = HNTextView(fontSize: 12)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(item: Item) {
        authorButton.set(title: item.by)
        dateLabel.text = item.time.relativeStringDate()

        commentTextLabel.text = item.text?.parseHTML()
        commentTextLabel.textColor = .label
    }

    private func configure() {
        contentView.addSubview(authorButton)
        contentView.addSubview(dateLabel)
        contentView.addSubview(commentTextLabel)

        authorButton.translatesAutoresizingMaskIntoConstraints = false

        let verticalPadding: CGFloat = 5
        let horizontalPadding: CGFloat = 15

        NSLayoutConstraint.activate([
            authorButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
            authorButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),
            authorButton.heightAnchor.constraint(equalToConstant: 14),

            dateLabel.topAnchor.constraint(equalTo: authorButton.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            dateLabel.heightAnchor.constraint(equalToConstant: 14),

            commentTextLabel.topAnchor.constraint(equalTo: authorButton.bottomAnchor, constant: 5),
            commentTextLabel.leadingAnchor.constraint(equalTo: authorButton.leadingAnchor),
            commentTextLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            commentTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding)
        ])
    }
    
}
