//
//  Set.swift
//  Set
//
//  Created by 张啸宇 on 2019/10/15.
//  Copyright © 2019年 张啸宇. All rights reserved.
//

import Foundation

class SetGame {

    private var cards = [Card]()

    var selectedCards = [Card]()

    var cardsOnScreen = [Card]()
    var canAddMoreCards: Bool {
        return cards.count > 0 && cardsOnScreen.count < 22
    }
    var score = 0

    private var isMatched: Bool {
        assert(selectedCards.count == 3, "selected card number:\(selectedCards.count)")
        let colorNumber = Set(selectedCards.map {
            $0.color
        }).count
        let shapeNumber = Set(selectedCards.map {
            $0.shape
        }).count
        let numberNumber = Set(selectedCards.map {
            $0.number
        }).count
        let shadingNumber = Set(selectedCards.map {
            $0.shading
        }).count
        return colorNumber != 2 && shapeNumber != 2 && numberNumber != 2 && shadingNumber != 2
    }

    func cardStateChanged(card: Card) {
        if selectedCards.contains(card) {
            // 点击的是已选过的牌
            selectedCards.remove(at: selectedCards.index(of: card)!)
            return
        }

        selectedCards.append(card)
        if selectedCards.count != 3 {
            return
        }

        // 需要判定
        if isMatched {
            for selectedCard in selectedCards {
                cardsOnScreen.remove(at: cardsOnScreen.index(of: selectedCard)!)
            }
            score += 1
        }
        selectedCards.removeAll()
    }

    // 再发三张牌
    func deal3moreCards() {
        if canAddMoreCards {
            for _ in 1...3 {
                cardsOnScreen.append(cards.remove(at: cards.randomindex))
            }
        }
    }

    init() {
        // 生成 81 张牌
        for number in CardNumber.all {
            for color in CardColor.all {
                for shape in CardShape.all {
                    for shading in CardShading.all {
                        let card = Card(color: color, shape: shape, number: number, shading: shading)
                        cards.append(card)
                    }
                }
            }
        }

        for _ in 1...4 {
            deal3moreCards()
        }
    }
}
