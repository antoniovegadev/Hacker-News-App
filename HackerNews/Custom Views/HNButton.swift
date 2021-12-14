//
//  HNButton.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/13/21.
//

import UIKit

class HNButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String) {
        self.init(frame: .zero)

        set(title: title)
    }

    func set(title: String) {
        var config = UIButton.Configuration.plain()
        var attr = AttributeContainer()
        attr.font = .systemFont(ofSize: 12, weight: .semibold)
        attr.foregroundColor = .systemOrange

        config.attributedTitle = AttributedString(title, attributes: attr)
        self.configuration = config
    }
}
