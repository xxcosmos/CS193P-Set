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
        return deck.count > 0
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

    func shuffle() {
        for _ in 1...1000 {
            cardsOnScreen.append(cardsOnScreen.remove(at: cardsOnScreen.randomIndex))
        }
    }
    // 点击有效卡片
    func cardStateChanged(card: Card) {
        if card.isMatched {
            return
        }
        if card.isSelected {
            // 点击的是已选过的牌
            card.isSelected = false
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
                    let index = cardsOnScreen.index(of: selectedCard)!
                    if !canAddMoreCards {
                        cardsOnScreen.remove(at: index)
                    }else{
                        drawCard(isAdd: false, index: index)
                    }
                }
                
                score += 3
            }
        }
    }
    
    // 再发张牌
    func drawCard(isAdd: Bool,index: Int) {
        if !canAddMoreCards {return}
        let newCard = deck.remove(at: deck.randomIndex)
        if isAdd {
            cardsOnScreen.append(newCard)
        } else {
            cardsOnScreen[index] = newCard
        }
       
        
    }


    init() {
        // 生成 81 张牌
        for number in Card.Number.all {
            for color in Card.Color.all {
                for shape in Card.Shape.all {
                    for shading in Card.Shading.all {
                        let card = Card(color: color, shape: shape, number: number, shading: shading)
                        deck.append(card)
                    }
                }
            }
        }

        for _ in 1...12 {
            drawCard(isAdd: true, index: 0)
        }
    }

}
