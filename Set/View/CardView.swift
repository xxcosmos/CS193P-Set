//
//  CardView.swift
//  Set
//
//  Created by 张啸宇 on 2019/10/22.
//  Copyright © 2019年 张啸宇. All rights reserved.
//

import UIKit

class CardView: UIView {
    var card:Card? {
        didSet {
            setNeedsDisplay()
        }
    }

    private var drawableRect: CGRect {
        return CGRect(x: frame.size.width * 0.1, y: frame.size.height * 0.05, width: frame.size.width * 0.8, height: frame.size.height * 0.9)
    }

    private var shapeHorizontalMargin: CGFloat {
        return drawableRect.width * 0.05
    }

    private var shapeVerticalMargin: CGFloat {
        return drawableRect.height * 0.05 + drawableRect.origin.y
    }

    private var shapeWidth: CGFloat {
        return (drawableRect.width - (2 * shapeHorizontalMargin)) / 3
    }

    private var shapeHeight: CGFloat {
        return drawableRect.size.height * 0.9
    }

    override func draw(_ rect: CGRect) {
        // Drawing code
        var path = getPathFromShape(shape: card!.shape, amount: card!.number)
        path.lineCapStyle = .round
        let uiColor = getColor(color: card!.color)
        path = addStyleToPath(path: path, shading: card!.shading, color: uiColor)
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func addStyleToPath(path: UIBezierPath,shading:Card.Shading,color: UIColor) -> UIBezierPath {
        switch shading {
        case .solid:
            color.setFill()
            path.fill()
        case .open:
            color.setStroke()
            path.lineWidth = 1
            path.stroke()
        case .striped:
            path.lineWidth = 0.01 * frame.size.width
            color.setStroke()
            path.addClip()
            var currentX: CGFloat = 0
            let stripedPath = UIBezierPath()
            stripedPath.lineWidth = 0.005 * frame.size.width

            while currentX < frame.size.width {
                stripedPath.move(to: CGPoint(x: currentX, y: 0))
                stripedPath.addLine(to: CGPoint(x: currentX, y: frame.size.height))
                currentX += 0.03 * frame.size.width
            }
            color.setStroke()
            stripedPath.stroke()
        }
        return path

    }

    func getColor(color: Card.Color) -> UIColor {
        switch color {
        case .green:
            return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .purple:
            return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case .red:
            return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
    }

    func getPathFromShape(shape: Card.Shape, amount: Card.Number) -> UIBezierPath {
        let path = UIBezierPath()
        switch shape {
        case .squiggle:
            return drawSquiggle(amount: amount.rawValue, path: path)
        case .diamond:
            return drawDiamonds(amount: amount.rawValue, path: path)
        case .oval:
            return drawOvals(amount: amount.rawValue, path: path)
        }
    }

    private func drawSquiggle(amount: Int,path: UIBezierPath) -> UIBezierPath {
        let width = CGFloat(amount) * shapeWidth + CGFloat(amount - 1) * shapeHorizontalMargin

        for i in 0..<amount {
            let currentShapeX = (frame.size.width - width) / 2 + (shapeWidth * CGFloat(i)) + (CGFloat(i) * shapeHorizontalMargin)
            let curveXOffset = shapeWidth * 0.35

            path.move(to: CGPoint(x: currentShapeX, y: shapeVerticalMargin))
            path.addCurve(to: CGPoint(x: currentShapeX, y: shapeVerticalMargin + shapeHeight), controlPoint1: CGPoint(x: currentShapeX + curveXOffset, y: shapeVerticalMargin + shapeHeight / 3), controlPoint2: CGPoint(x: currentShapeX - curveXOffset, y: shapeVerticalMargin + (shapeHeight / 3) * 2))
            path.addLine(to: CGPoint(x: currentShapeX + shapeWidth, y: shapeVerticalMargin + shapeHeight))
            path.addCurve(to: CGPoint(x: currentShapeX + shapeWidth, y: shapeVerticalMargin), controlPoint1: CGPoint(x: currentShapeX + shapeWidth - curveXOffset, y: shapeVerticalMargin + (shapeHeight / 3) * 2), controlPoint2: CGPoint(x: currentShapeX + shapeWidth + curveXOffset, y: shapeVerticalMargin + shapeHeight / 3))
            path.addLine(to: CGPoint(x: currentShapeX, y: shapeVerticalMargin))
        }

        return path
    }

    /// Draws the ovals to the drawable rect.
    private func drawOvals(amount: Int,path: UIBezierPath) -> UIBezierPath {
        let width = CGFloat(amount) * shapeWidth + CGFloat(amount - 1) * shapeHorizontalMargin

        for i in 0..<amount {
            let currentShapeX = (frame.size.width - width) / 2 + (shapeWidth * CGFloat(i)) + (CGFloat(i) * shapeHorizontalMargin)
            path.append(UIBezierPath(roundedRect: CGRect(x: currentShapeX, y: shapeVerticalMargin, width: shapeWidth, height: shapeHeight), cornerRadius: shapeWidth))
        }
        return path
    }

    /// Draws the diamonds to the drawable rect.
    private func drawDiamonds(amount: Int,path: UIBezierPath) -> UIBezierPath {
        let width = CGFloat(amount) * shapeWidth + CGFloat(amount - 1) * shapeHorizontalMargin

        for i in 0..<amount {
            let currentShapeX = (frame.size.width - width) / 2 + (shapeWidth * CGFloat(i)) + (CGFloat(i) * shapeHorizontalMargin)

            path.move(to: CGPoint(x: currentShapeX + shapeWidth / 2, y: shapeVerticalMargin))
            path.addLine(to: CGPoint(x: currentShapeX, y: bounds.height / 2))
            path.addLine(to: CGPoint(x: currentShapeX + shapeWidth / 2, y: shapeVerticalMargin + shapeHeight))
            path.addLine(to: CGPoint(x: currentShapeX + shapeWidth, y: bounds.height / 2))
            path.addLine(to: CGPoint(x: currentShapeX + shapeWidth / 2, y: shapeVerticalMargin))
        }

        return path
    }


}
