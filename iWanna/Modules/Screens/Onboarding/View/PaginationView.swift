//
//  PaginationView.swift
//  iWanna
//
//  Created by George Weaver on 27.06.2023.
//

import UIKit

final class PaginationView: UIStackView {

    var numberOfPages: Int = 0 {
        didSet {
            for tag in 0..<numberOfPages {
                let item = PaginatioinItem()
                item.tag = tag
                self.items.append(item)
            }
        }
    }

    var currentPage: Int = 0 {
        didSet {
            items[oldValue].layer.borderColor = UIColor.black.cgColor
            items[oldValue].backgroundColor = .white
            items[currentPage].layer.borderColor = R.color.background_yellow()?.cgColor
            items[currentPage].backgroundColor = R.color.background_yellow()
        }
    }
    
    private var items: [UIView] = [] {
        didSet {
            if items.count == numberOfPages {
                setupUI()
            }
        }
    }

    private func setupUI() {
        items.forEach { addArrangedSubview($0) }
        self.axis = .horizontal
        self.spacing = 6
    }

}

final class PaginatioinItem: UIView {
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 12, height: 12)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = min(frame.width, frame.height / 2)
        self.layer.borderWidth = 1
    }
}
