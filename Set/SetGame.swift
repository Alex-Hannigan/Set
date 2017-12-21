//
//  SetGame.swift
//  Set
//
//  Created by Alex Hannigan on 2017/12/19.
//  Copyright © 2017年 Alex Hannigan. All rights reserved.
//

import Foundation

struct SetGame {
    private var cardColors = [Card.Color.color1, Card.Color.color2, Card.Color.color3]
    private var cardShapes = [Card.Shape.shape1, Card.Shape.shape2, Card.Shape.shape3]
    private var cardNumberOfShapes = [Card.NumberOfShapes.one, Card.NumberOfShapes.two, Card.NumberOfShapes.three]
    private var cardFillStyles = [Card.FillStyle.filled, Card.FillStyle.striped, Card.FillStyle.stroked]
    
    private (set) var deck = [Card]()
    
    private (set) var dealtCards = [Card]()
    
    var selectedCards = [Int: Card]()
    
    init(numberOfCards: Int) {
        
        for cardColorIndex in 0...cardColors.count - 1 {
            let cardColor = cardColors[cardColorIndex]
            for cardShapeIndex in 0...cardShapes.count - 1 {
                let cardShape = cardShapes[cardShapeIndex]
                for cardNumberOfShapesIndex in 0...cardNumberOfShapes.count - 1 {
                    let cardNumberOfShapesOnCard = cardNumberOfShapes[cardNumberOfShapesIndex]
                    for cardFillStyleIndex in 0...cardFillStyles.count - 1 {
                        let cardFillStyle = cardFillStyles[cardFillStyleIndex]
                        deck.append(Card(color: cardColor, shape: cardShape, numberOfShapes: cardNumberOfShapesOnCard, fillStyle: cardFillStyle))
                    }
                }
            }
        }
        
        for _ in 0...numberOfCards - 1 {
            dealtCards.append(deck.remove(at: (deck.count - 1).arc4random))
        }
    }
    
    mutating func deal3MoreCards() {
        for _ in 0...2 {
            dealtCards.append(deck.remove(at: (deck.count - 1).arc4random))
        }
    }
    
    mutating func selectCard(at index: Int) {
        if selectedCards[index] == nil {
            selectedCards[index] = dealtCards[index]
        }
        else {
            selectedCards.removeValue(forKey: index)
        }
    }
}
