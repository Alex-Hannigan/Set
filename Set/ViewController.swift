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
    
    var numberOfCards: Int {
        return cardButtons.count
    }
    
    @IBAction func touchCard(_ sender: RoundedButton) {
        print("A card was touched")
    }
    
    @IBAction func deal3MoreCards(_ sender: RoundedButton) {
        print("Deal 3 more cards button pressed")
        print(game.deck)
    }
    
    @IBAction func newGame(_ sender: RoundedButton) {
        print("New Game button pressed")
        game = SetGame(numberOfCards: numberOfCards)
        updateViewFromModel()
    }
    
    lazy private var game = SetGame(numberOfCards: numberOfCards)
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.dealtCards[index]
            let cardFaceString = String(repeating: shapeChoices[card.shape] ?? "?", count: numberOfShapesChoices[card.numberOfShapes] ?? 1)
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
