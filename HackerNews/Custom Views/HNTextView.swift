//
//  HNTextView.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/19/21.
//

import UIKit

class HNTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero, textContainer: nil)

        font = .systemFont(ofSize: fontSize)
    }

    private func configure() {
        textAlignment = .left
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
        isSelectable = true
        isEditable = false
        isScrollEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
    }
}
