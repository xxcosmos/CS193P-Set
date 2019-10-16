//
//  Card.swift
//  Set
//
//  Created by 张啸宇 on 2019/10/15.
//  Copyright © 2019年 张啸宇. All rights reserved.
//

import Foundation

// 牌类
class Card: Equatable{
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color && lhs.number == rhs.number && lhs.shading == rhs.shading && lhs.shape == rhs.shape
    }
    
    var color: CardColor
    var shape: CardShape
    var number: CardNumber
    var shading: CardShading

    init(color:CardColor,shape: CardShape, number: CardNumber, shading: CardShading) {
        self.color = color
        self.shape = shape
        self.number = number
        self.shading = shading

    }
}
