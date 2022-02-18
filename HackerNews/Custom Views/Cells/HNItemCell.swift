//
//  HNItemCell.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/12/21.
//

import UIKit
import SkeletonView

protocol HNItemCellDelegate: AnyObject {
    func didTapLinkLabel(for item: Item)
}

class HNItemCell: UITableViewCell {
    weak var delegate: HNItemCellDelegate!
    var item: Item!

    static let reuseID = "HNItemCell"

    let header = UIStackView()
    let rankLabel = HNBodyLabel(fontSize: 12)
    let linkLabel = HNButton()
    let titleLabel = HNTitleLabel(textAlignment: .left, fontSize: 16)
    let authorLabel = HNBodyLabel(fontSize: 12)
    let footer = UIStackView()
    let upvoteLabel = HNSymbolTextView(symbol: .upArrow)
    let commentLabel = HNSymbolTextView(symbol: .textBubble)
    let dateLabel = HNSymbolTextView(symbol: .clock)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configure()
        configureLinkLabel()
        configureHeader()
        configureFooter()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(item: Item) {
        self.item = item
        rankLabel.text = String(item.rank) + "."
        linkLabel.set(title: item.urlString?.strippedURL() ?? "www.google.com")
        titleLabel.text = item.title
        authorLabel.text = item.author
        upvoteLabel.set(text: String(item.score!))
        commentLabel.set(text: String(item.wrappedCommentCount))
        dateLabel.set(text: item.dateCreated.relativeStringDate())
    }

    private func configure() {
        contentView.addSubview(header)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(footer)

        self.isSkeletonable = true
        contentView.isSkeletonable = true
        header.isSkeletonable = true
        header.isHiddenWhenSkeletonIsActive = true
        
        titleLabel.isSkeletonable = true
        titleLabel.skeletonTextNumberOfLines = 4
        titleLabel.linesCornerRadius = 5

        authorLabel.isSkeletonable = true
        authorLabel.isHiddenWhenSkeletonIsActive = true

        footer.isSkeletonable = true
        footer.isHiddenWhenSkeletonIsActive = true

        let padding: CGFloat = 20

        header.translatesAutoresizingMaskIntoConstraints = false
        footer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: contentView.topAnchor),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),

            titleLabel.topAnchor.constraint(equalTo: header.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),

            footer.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 15),
            footer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            footer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)
        ])
    }

    private func configureLinkLabel() {
        linkLabel.addTarget(self, action: #selector(linkLabelTapped), for: .touchUpInside)
    }

    private func configureHeader() {
        header.axis = .horizontal
        header.spacing = 5
        
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

    @objc func linkLabelTapped() {
        delegate.didTapLinkLabel(for: item)
    }
}
