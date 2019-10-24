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

    var color: Color
    var shape: Shape
    var number: Number
    var shading: Shading
    var isSelected = false
    var isMatched = false

    init(color: Color, shape: Shape, number: Number, shading: Shading) {
        self.color = color
        self.shape = shape
        self.number = number
        self.shading = shading
    }

    enum Color: String{
        case red
        case green
        case purple

        static let all = [red,green,purple]
    }

    enum Number: Int {
        case one = 1
        case two = 2
        case three = 3

        static let all = [one, two, three]
    }

    enum Shading: String {
        case solid
        case striped
        case open

        static let all = [solid, striped, open]
    }

    enum Shape:String {
        case diamond
        case squiggle
        case oval

        static let all = [diamond, squiggle, oval]
    }

}
