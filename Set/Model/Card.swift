//
//  Card.swift
//  Set
//
//  Created by 张啸宇 on 2019/10/15.
//  Copyright © 2019年 张啸宇. All rights reserved.
//

import Foundation

// 牌类
class Card: Hashable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color && lhs.shape == rhs.shape && lhs.shading == rhs.shading && lhs.number == rhs.number
    }

    var hashValue: Int {
        return color.hashValue + shape.hashValue * 10 + number.hashValue * 100 + shading.hashValue * 1000
    }

    var color: CardColor
    var shape: CardShape
    var number: CardNumber
    var shading: CardShading
    var isSelected = false
    var isMatched = false

    init(color: CardColor, shape: CardShape, number: CardNumber, shading: CardShading) {
        self.color = color
        self.shape = shape
        self.number = number
        self.shading = shading
    }
}
