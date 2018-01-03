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
    }
    
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var tableSpaceForCards: UIView! { didSet { updateViewFromModel() } }
    
    var maxNumberOfCards: Int {
        return tableSpaceForCards.subviews.count
    }
    
    // The number of cards that are dealt at the start of a new game
    let startNumberOfCards = 12
    
    var numberOfSelectedCards: Int {
        return game.selectedCards.count
    }
    
    @objc private func touchCard(_ recognizer: UITapGestureRecognizer) {
        if let viewTapped = recognizer.view {
            if let index = tableSpaceForCards.subviews.index(of: viewTapped) {
                game.selectCard(at: index)
                updateViewFromModel()
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
    
    @IBAction func shuffleDealtCards(_ sender: UIRotationGestureRecognizer) {
        game.shuffleDealtCards()
        updateViewFromModel()
    }
    
    
    // Set up a connection to the model
    lazy private var game = SetGame(numberOfCards: startNumberOfCards)
    
    // Sync up the view with the model
    private func updateViewFromModel() {
        for view in tableSpaceForCards.subviews {
            view.removeFromSuperview()
        }
        if !game.gameOver {
            var grid = Grid(layout: .aspectRatio(tableSpaceForCards.bounds.width / tableSpaceForCards.bounds.height), frame: tableSpaceForCards.bounds)
            grid.cellCount = game.dealtCards.count
            for index in 0...grid.cellCount - 1 {
                if let cell = grid[index] {
                    let cardView = SetCardView(frame: cell)
                    cardView.isOpaque = false
                    cardView.frame = cardView.frame.insetBy(dx: cardView.frame.width * 0.05, dy: cardView.frame.width * 0.05)
                    if let card = game.dealtCards.indices.contains(index) ? game.dealtCards[index] : nil {
                        switch card.color {
                            case .color1: cardView.color = .red
                            case .color2: cardView.color = .purple
                            case .color3: cardView.color = .green
                        }
                        switch card.fillStyle {
                            case .filled: cardView.shading = .solid
                            case .striped: cardView.shading = .striped
                            case .stroked: cardView.shading = .open
                        }
                        switch card.numberOfShapes {
                            case .one: cardView.numberOfShapes = .one
                            case .two: cardView.numberOfShapes = .two
                            case .three: cardView.numberOfShapes = .three
                        }
                        switch card.shape {
                            case .shape1: cardView.shape = .diamond
                            case .shape2: cardView.shape = .oval
                            case .shape3: cardView.shape = .squiggle
                        }
                        if game.selectedCards[index] != nil {
                            cardView.layer.borderWidth = 3.0
                            cardView.layer.borderColor = UIColor.blue.cgColor
                        }
                        else {
                            cardView.layer.borderWidth = 0.0
                        }
                    }
                    let tap = UITapGestureRecognizer(target: self, action: #selector(touchCard))
                    tap.numberOfTapsRequired = 1
                    cardView.addGestureRecognizer(tap)
                    tableSpaceForCards.addSubview(cardView)
                }
            }
            scoreLabel.text = "Score: \(game.score)"
        }
        else {
            scoreLabel.text = "YOU WIN"
        }
    }
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
