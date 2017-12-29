//
//  Card.swift
//  Set
//
//  Created by Alex Hannigan on 2017/12/18.
//  Copyright © 2017年 Alex Hannigan. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int { return identifier }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    enum Color {
        case color1
        case color2
        case color3
        
        static var all = [Color.color1, .color2, .color3]
    }
    
    enum Shape {
        case shape1
        case shape2
        case shape3
        
        static var all = [Shape.shape1, .shape2, .shape3]
    }
    
    enum NumberOfShapes {
        case one
        case two
        case three
        
        static var all = [NumberOfShapes.one, .two, .three]
    }
    
    enum FillStyle {
        case filled
        case stroked
        case striped
        
        static var all = [FillStyle.filled, .stroked, .striped]
    }
    
    var color: Color
    var shape: Shape
    var numberOfShapes: NumberOfShapes
    var fillStyle: FillStyle
    
    private let identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(color: Color, shape: Shape, numberOfShapes: NumberOfShapes, fillStyle: FillStyle) {
        self.identifier = Card.getUniqueIdentifier()
        self.color = color
        self.shape = shape
        self.numberOfShapes = numberOfShapes
        self.fillStyle = fillStyle
    }
}
