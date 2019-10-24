//
// Created by 张啸宇 on 2019/10/24.
// Copyright (c) 2019 张啸宇. All rights reserved.
//

import UIKit
class CardContainerView: UIView {
    private (set) var cards = [CardView]()
    private (set) var grid = Grid(layout: Grid.Layout.aspectRatio(3/2))
    private var centeredRect: CGRect {
        get {
            return CGRect(x: bounds.size.width * 0.025,
                    y: bounds.size.height * 0.025,
                    width: bounds.size.width * 0.95,
                    height: bounds.size.height * 0.95)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        grid.frame = centeredRect
        for(i,card) in cards.enumerated() {
            if let frame = grid[i] {
                card.frame = frame
                card.layer.cornerRadius = 10
                card.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                card.layer.borderWidth = 0.5
            }
        }
    }

    func addCardIntoView(amount: Int = 3) {
        for _ in 1...amount {
            let card = CardView()
            addSubview(card)
            cards.append(card)
        }
        grid.cellCount = cards.count
        setNeedsLayout()
    }

    func removeCard(amount: Int) {
        guard cards.count >= amount else {return}
        for index in 0..<amount {
            cards[index].removeFromSuperview()
        }
        cards.removeSubrange(0..<amount)
        grid.cellCount = cards.count
        setNeedsLayout()
    }

    func clearCardContainer() {
        cards = []
        grid.cellCount = 0
        for subView in subviews {
            subView.removeFromSuperview()
        }
        setNeedsLayout()
    }
}