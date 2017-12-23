//
//  ViewController.swift
//  Set
//
//  Created by Alex Hannigan on 2017/12/18.
//  Copyright © 2017年 Alex Hannigan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    @IBOutlet var cardButtons: [RoundedButton]!
    
    var maxNumberOfCards: Int {
        return cardButtons.count
    }
    
    let startNumberOfCards = 12
    
    private var currentNumberOfCards = 12
    
    var numberOfSelectedCards: Int {
        return game.selectedCards.count
    }
    
    @IBAction func touchCard(_ sender: RoundedButton) {
            if let cardIndex = cardButtons.index(of: sender) {
                if game.dealtCards.indices.contains(cardIndex) {
                if numberOfSelectedCards >= 3 {
                    if game.cardsAreSet() { print("SET!!!!!") }
                    game.selectedCards = [Int : Card]()
                    updateViewFromModel()
                }
                else {
                game.selectCard(at: cardIndex)
                updateViewFromModel()
                    }
            }
        }
    }
    
    @IBAction func deal3MoreCards(_ sender: RoundedButton) {
        game.deal3MoreCards()
        updateViewFromModel()
    }
    
    @IBAction func newGame(_ sender: RoundedButton) {
        game = SetGame(numberOfCards: startNumberOfCards)
        updateViewFromModel()
    }
    
    lazy private var game = SetGame(numberOfCards: startNumberOfCards)
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            
            if let card = game.dealtCards.indices.contains(index) ? game.dealtCards[index] : nil {
                let cardFaceString = String(repeating: shapeChoices[card.shape] ?? " ", count: numberOfShapesChoices[card.numberOfShapes] ?? 1)
                let strokeWidth = fillStyleChoices[card.fillStyle]
                var foregroundColor: UIColor {
                    return colorChoices[card.color] ?? UIColor.black
                }
                var strokeColor: UIColor {
                    return foregroundColor
                }
                var foregroundAlpha: CGFloat {
                    switch card.fillStyle {
                    case .striped:
                        return 0.25
                    default:
                        return 1.0
                    }
                }
                var strokeAlpha: CGFloat {
                    switch card.fillStyle {
                    case .striped:
                        return 0.0
                    default :
                        return 1.0
                    }
                }
                let attributes: [NSAttributedStringKey: Any] = [
                    .strokeWidth : strokeWidth ?? 5.0,
                    .foregroundColor : foregroundColor.withAlphaComponent(foregroundAlpha),
                    .strokeColor : strokeColor.withAlphaComponent(strokeAlpha)
                ]
                let attributedString = NSAttributedString(string: cardFaceString, attributes: attributes)
                button.setAttributedTitle(attributedString, for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                
                if game.selectedCards[index] != nil {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.blue.cgColor
                }
                else {
                    button.layer.borderWidth = 0.0
                }
            }
            else {
                let attributes: [NSAttributedStringKey: Any] = [
                    .strokeWidth : 5.0,
                ]
                button.setTitle(" ", for: UIControlState.normal)
                button.setAttributedTitle(NSAttributedString(string: " ", attributes: attributes), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                button.layer.borderWidth = 0.0
            }
        }
    }
    
    private var shapeChoices = [
        Card.Shape.shape1 : "▲",
        Card.Shape.shape2 : "●",
        Card.Shape.shape3 : "◼︎"
    ]
    
    private var numberOfShapesChoices = [
        Card.NumberOfShapes.one : 1,
        Card.NumberOfShapes.two : 2,
        Card.NumberOfShapes.three : 3
    ]
    
    private var fillStyleChoices = [
        Card.FillStyle.filled : -1.0,
        Card.FillStyle.striped : -1.0,
        Card.FillStyle.stroked : 5.0
    ]
    
    private var colorChoices = [
        Card.Color.color1 : #colorLiteral(red: 0.9214526415, green: 0.2879634154, blue: 0.4003171446, alpha: 1),
        Card.Color.color2 : #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1),
        Card.Color.color3 : #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    ]
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }
        else {
            return 0
        }
    }
}
