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
        
        static func element(at index: Int) -> Color? {
            let elements = [Color.color1, Color.color2, Color.color3]
            if index >= 0 && index < elements.count {
                return elements[index]
            }
            else {
                return nil
            }
        }
    }
    
    enum Shape {
        case shape1
        case shape2
        case shape3
        
        static func element(at index: Int) -> Shape? {
            let elements = [Shape.shape1, Shape.shape2, Shape.shape3]
            if index >= 0 && index < elements.count {
                return elements[index]
            }
            else {
                return nil
            }
        }
    }
    
    enum NumberOfShapes {
        case one
        case two
        case three
        
        static func element(at index: Int) -> NumberOfShapes? {
            let elements = [NumberOfShapes.one, NumberOfShapes.two, NumberOfShapes.three]
            if index >= 0 && index < elements.count {
                return elements[index]
            }
            else {
                return nil
            }
        }
    }
    
    enum FillStyle {
        case filled
        case stroked
        case striped
        
        static func element(at index: Int) -> FillStyle? {
            let elements = [FillStyle.filled, FillStyle.stroked, FillStyle.striped]
            if index >= 0 && index < elements.count {
                return elements[index]
            }
            else {
                return nil
            }
        }
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
