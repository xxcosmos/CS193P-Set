//
//  Common.swift
//  Set
//
//  Created by 张啸宇 on 2019/10/15.
//  Copyright © 2019年 张啸宇. All rights reserved.
//

import Foundation

extension Int {
    func arc4random() -> Int {
        if self == 0{
            return 0
        }
        if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        return Int(arc4random_uniform((UInt32(self))))
    }
}

extension Array {
    var randomIndex: Int {
        return Int(arc4random_uniform(UInt32(count - 1)))
    }
}
