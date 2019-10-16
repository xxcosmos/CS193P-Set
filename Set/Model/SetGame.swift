//
//  Set.swift
//  Set
//
//  Created by 张啸宇 on 2019/10/15.
//  Copyright © 2019年 张啸宇. All rights reserved.
//

import Foundation

class SetGame {

    private var deck = [Card]()
    var cardsOnScreen = [Card]()

    var selectedCards: [Card] {
        return cardsOnScreen.filter {
            $0.isSelected
        }
    }

    var matchedCards: [Card] {
        return cardsOnScreen.filter {
            $0.isMatched
        }
    }

    var canAddMoreCards: Bool {
        return deck.count > 0 && cardsOnScreen.count - matchedCards.count < 22
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
        return colorNumber != 2 || shapeNumber != 2 || numberNumber != 2 || shadingNumber != 2
    }

    // 点击有效卡片
    func cardStateChanged(card: Card) {
        if card.isMatched {
            return
        }
        if card.isSelected {
            // 点击的是已选过的牌
            card.isSelected = false
            score -= 1
            return
        }
        // 未选过
        if selectedCards.count == 3 {
            for selectedCard in selectedCards {
                selectedCard.isSelected = false
            }
        }
        card.isSelected = true

        if selectedCards.count == 3 {
            // 需要判定
            if isMatched {
                for selectedCard in selectedCards {
                    selectedCard.isMatched = true
                }
                deal3moreCards()
                score += 3
            }else {
                score -= 5
            }
        }
    }

    // 再发三张牌
    func deal3moreCards() {
        if canAddMoreCards {
            if matchedCards.count > 2 {
                for _ in 1...3 {
                    let matchedCard = matchedCards[matchedCards.randomIndex]
                    cardsOnScreen[cardsOnScreen.index(of: matchedCard)!] = deck.remove(at: deck.randomIndex)
                }
                return
            }

            for _ in 1...3 {
                cardsOnScreen.append(deck.remove(at: deck.randomIndex))
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
                        deck.append(card)
                    }
                }
            }
        }

        for _ in 1...4 {
            deal3moreCards()
        }
    }

}