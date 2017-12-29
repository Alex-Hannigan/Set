//
//  SetGame.swift
//  Set
//
//  Created by Alex Hannigan on 2017/12/19.
//  Copyright © 2017年 Alex Hannigan. All rights reserved.
//

import Foundation

struct SetGame {
    // Arrays which hold all of the possible features that can be used to define a card
    private var cardColors = [Card.Color.color1, Card.Color.color2, Card.Color.color3]
    private var cardShapes = [Card.Shape.shape1, Card.Shape.shape2, Card.Shape.shape3]
    private var cardNumberOfShapes = [Card.NumberOfShapes.one, Card.NumberOfShapes.two, Card.NumberOfShapes.three]
    private var cardFillStyles = [Card.FillStyle.filled, Card.FillStyle.striped, Card.FillStyle.stroked]
    
    // The deck of cards, this will be initialized later with 81 unique cards
    private (set) var deck = [Card]()
    
    // Cards that have been dealt and are currently displayed in the UI
    private (set) var dealtCards = [Card]()
    
    // A number of cards that have been selected (tapped) by the user
    var selectedCards = [Int: Card]()
    
    private (set) var score = 0
    
    private (set) var gameOver = false
    
    // Initializer which takes one parameter - the number of cards to be dealt at the start of the game
    // This populates the deck with 81 unique cards - one for each possible combination of features
    // It then 'deals' a specified number of them, removing them from the deck
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
        
        for _ in 1...numberOfCards {
            dealtCards.append(deck.remove(at: (deck.count - 1).arc4random))
        }
    }
    
    mutating func deal3MoreCards() {
        for _ in 1...3 {
            if deck.count > 0 {
                dealtCards.append(deck.remove(at: (deck.count - 1).arc4random))
            }
        }
    }
    
    mutating func selectCard(at index: Int) {
        var selectedCardIndex = index
        if selectedCards.count == 3 {
            let selectedCard = dealtCards[selectedCardIndex]
            if cardsAreSet() {
                selectedCardIndex = dealtCards.index(of: selectedCard) ?? selectedCardIndex
                score += 10
                if dealtCards.isEmpty {
                    gameOver = true
                }
            }
            else {
                score -= 10
            }
            selectedCards = [:]
        }
        if selectedCards[selectedCardIndex] == nil, dealtCards.indices.contains(selectedCardIndex) {
            selectedCards[selectedCardIndex] = dealtCards[selectedCardIndex]
        }
        else {
            selectedCards.removeValue(forKey: selectedCardIndex)
            score -= 1
        }
    }
    
    mutating func cardsAreSet() -> Bool {
        let cards = Array(selectedCards.values)
        let card1 = cards[0], card2 = cards[1], card3 = cards[2]
        if ((card1.color == card2.color && card2.color == card3.color) || (card1.color != card2.color && card2.color != card3.color))
            &&
            ((card1.fillStyle == card2.fillStyle && card2.fillStyle == card3.fillStyle) || (card1.fillStyle != card2.fillStyle && card2.fillStyle != card3.fillStyle))
            &&
            ((card1.numberOfShapes == card2.numberOfShapes && card2.numberOfShapes == card3.numberOfShapes) || (card1.numberOfShapes != card2.numberOfShapes && card2.numberOfShapes != card3.numberOfShapes))
            &&
            ((card1.shape == card2.shape && card2.shape == card3.shape) || (card1.shape != card2.shape && card2.shape != card3.shape)) {
            let selectedCardsIndexArray = Array(selectedCards.keys)
            var indexesOfCardsToRemove = [Int]()
            if deck.count > 0 {
                dealtCards[selectedCardsIndexArray[0]] = deck.remove(at: (deck.count - 1).arc4random)
            }
            else {
                indexesOfCardsToRemove.append(selectedCardsIndexArray[0])
            }
            if deck.count > 0 {
                dealtCards[selectedCardsIndexArray[1]] = deck.remove(at: (deck.count - 1).arc4random)
            }
            else {
                indexesOfCardsToRemove.append(selectedCardsIndexArray[1])
            }
            if deck.count > 0 {
                dealtCards[selectedCardsIndexArray[2]] = deck.remove(at: (deck.count - 1).arc4random)
            }
            else {
                indexesOfCardsToRemove.append(selectedCardsIndexArray[2])
            }

            for _ in indexesOfCardsToRemove {
                if let max = indexesOfCardsToRemove.max() {
                    dealtCards.remove(at: max)
                    if let index = indexesOfCardsToRemove.index(of: max) {
                        indexesOfCardsToRemove.remove(at: index)
                    }
                }
            }
            return true
        }
        else {
            return false
        }
    }
}
