//
//  SetCardView.swift
//  GraphicalSet
//
//  Created by Alex Hannigan on 2017/12/29.
//  Copyright © 2017年 Alex Hannigan. All rights reserved.
//

import UIKit

class SetCardView: UIView {
    
    var color: Color = .purple { didSet { setNeedsDisplay() } }
    var shape: Shape = .squiggle { didSet { setNeedsDisplay() } }
    var numberOfShapes: NumberOfShapes = .one { didSet { setNeedsDisplay() } }
    var shading: Shading = .solid { didSet { setNeedsDisplay() } }
    private let cornerRadiusToBoundsHeight: CGFloat = 0.06
    private let roundedRectCornerRadiusToShapeHeightRatio: CGFloat = 1.0
    private let lineWidth: CGFloat = 5.0
    private let stripeSpacingToShapeWidthRatio: CGFloat = 0.15
    
    enum Color {
        case red
        case purple
        case green
    }
    
    enum Shape {
        case diamond
        case oval
        case squiggle
    }
    
    enum NumberOfShapes: Int {
        case one = 1
        case two = 2
        case three = 3
    }
    
    enum Shading {
        case solid
        case striped
        case open
    }
    
    
    override func draw(_ rect: CGRect) {
        //Draw card background
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height * cornerRadiusToBoundsHeight)
        roundedRect.addClip()
        let bgColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        bgColor.setFill()
        roundedRect.fill()
        
        var paths = [UIBezierPath]()
        let shapeSize = CGSize(width: bounds.width * 0.75, height: bounds.height * 0.2)
        let originOfTheOneAndOnlyShape = CGPoint(x: bounds.midX - shapeSize.width/2, y: bounds.midY - shapeSize.height/2)
        let originOfTheFirstOfTwoShapes = CGPoint(x: bounds.midX - shapeSize.width/2, y: bounds.midY - shapeSize.height * 1.5)
        let originOfTheSecondOfTwoShapes = CGPoint(x: bounds.midX - shapeSize.width/2, y: bounds.midY + shapeSize.height/2)
        let originOfTheFirstOfThreeShapes = CGPoint(x: bounds.midX - shapeSize.width/2, y: bounds.midY - shapeSize.height/2 - shapeSize.height * 1.5)
        var originOfTheSecondOfThreeShapes: CGPoint { return originOfTheOneAndOnlyShape }
        let originOfTheThirdOfThreeShapes = CGPoint(x: bounds.midX - shapeSize.width/2, y: bounds.midY + shapeSize.height)
        var boundingRectangles = [CGRect]()
        
        switch numberOfShapes {
        case .one:
            let boundingRectangle = CGRect(origin: originOfTheOneAndOnlyShape, size: shapeSize)
            boundingRectangles.append(boundingRectangle)
        case .two:
            let upperBoundingRectangle = CGRect(origin: originOfTheFirstOfTwoShapes, size: shapeSize)
            let lowerBoundingRectangle = CGRect(origin: originOfTheSecondOfTwoShapes, size: shapeSize)
            boundingRectangles.append(upperBoundingRectangle)
            boundingRectangles.append(lowerBoundingRectangle)
        case .three:
            let upperBoundingRectangle = CGRect(origin: originOfTheFirstOfThreeShapes, size: shapeSize)
            let middleBoundingRectangle = CGRect(origin: originOfTheSecondOfThreeShapes, size: shapeSize)
            let lowerBoundingRectangle = CGRect(origin: originOfTheThirdOfThreeShapes, size: shapeSize)
            boundingRectangles.append(upperBoundingRectangle)
            boundingRectangles.append(middleBoundingRectangle)
            boundingRectangles.append(lowerBoundingRectangle)
        }
        
        switch shape {
        case .diamond: drawDiamond(for: boundingRectangles)
        case .oval: drawOval(for: boundingRectangles)
        case .squiggle: drawSquiggle(for: boundingRectangles)
        }
        
    }
    
    private func drawDiamond(for rects: [CGRect]) {
        for rect in rects {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.close()
            let context = UIGraphicsGetCurrentContext()
            context?.saveGState()
            path.addClip()
            setColor()
            setShading(within: rect, for: path)
            context?.restoreGState()
        }
    }
    
    private func drawOval(for rects: [CGRect]) {
        for rect in rects {
            let path = UIBezierPath(roundedRect: rect, cornerRadius: roundedRectCornerRadiusToShapeHeightRatio * rect.height)
            let context = UIGraphicsGetCurrentContext()
            context?.saveGState()
            path.addClip()
            setColor()
            setShading(within: rect, for: path)
            context?.restoreGState()
        }
    }
    
    private func drawSquiggle(for rects: [CGRect]) {
        for rect in rects {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addCurve(to: CGPoint(x: rect.maxX - rect.width * 0.1, y: rect.minY), controlPoint1: CGPoint(x: rect.minX + rect.width * 0.33, y: rect.minY - rect.height * 0.5), controlPoint2: CGPoint(x: rect.maxX - rect.width * 0.33, y: rect.maxY))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), controlPoint: CGPoint(x: rect.maxX + rect.width * 0.1, y: rect.minY + rect.height * 0.2))
            path.addCurve(to: CGPoint(x: rect.minX + rect.width * 0.1, y: rect.maxY), controlPoint1: CGPoint(x: rect.maxX - rect.width * 0.33, y: rect.maxY + rect.height * 0.5), controlPoint2: CGPoint(x: rect.minX + rect.width * 0.33, y: rect.minY))
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.midY), controlPoint: CGPoint(x: rect.minX - rect.width * 0.1, y: rect.maxY - rect.height * 0.2))
            let context = UIGraphicsGetCurrentContext()
            context?.saveGState()
            path.addClip()
            setColor()
            setShading(within: rect, for: path)
            context?.restoreGState()
        }
    }
    
    private func setColor() {
        switch color {
        case .red: UIColor.red.set()
        case .purple: UIColor.purple.set()
        case .green: UIColor.green.set()
        }
    }
    
    private func drawStripes(within rect: CGRect) {
        let stripePath = UIBezierPath()
        stripePath.lineWidth = lineWidth * 0.5
        for x in stride(from: rect.minX, through: rect.maxX, by: stripeSpacingToShapeWidthRatio * rect.width) {
            stripePath.move(to: CGPoint(x: x, y: rect.minY))
            stripePath.addLine(to: CGPoint(x: x, y: rect.maxY))
        }
        stripePath.stroke()
    }
    
    private func setShading(within rect: CGRect, for path: UIBezierPath) {
        switch shading {
        case .open:
            path.lineWidth = lineWidth
            path.stroke()
        case .solid: path.fill()
        case .striped:
            path.lineWidth = lineWidth
            path.stroke()
            drawStripes(within: rect)
        }
    }
    
}

