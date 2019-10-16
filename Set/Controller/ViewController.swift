//
//  ViewController.swift
//  Set
//
//  Created by 张啸宇 on 2019/10/15.
//  Copyright © 2019年 张啸宇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var game = SetGame()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var deal3MoreCardButton: UIButton!

    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.index(of: sender) {
            if game.cardsOnScreen.indices.contains(cardIndex) {
                game.cardStateChanged(card: game.cardsOnScreen[cardIndex])
                updateView()
            }
        } else {
            print("Error: chosen card is not in cardButtons")
        }
    }

    func initButton() {
        for button in cardButtons {
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
            button.layer.borderWidth = 0
            button.layer.cornerRadius = 0
            button.setTitle("", for: .normal)
            var attributes: [NSAttributedStringKey: Any] = [:]
            attributes[.foregroundColor] = UIColor.clear.withAlphaComponent(1)
            let attributedString = NSAttributedString(string: "", attributes: attributes)
            button.setAttributedTitle(attributedString, for: .normal)
        }
    }

    func updateView() {
        initButton()
        scoreLabel.text = "Score: \(game.score)"

        if game.canAddMoreCards {
            deal3MoreCardButton.isEnabled = true
        } else {
            deal3MoreCardButton.isEnabled = false
        }
        for item in cardButtons.indices {
            let button = cardButtons[item]
            if game.cardsOnScreen.indices.contains(item) {
                paintCard(button: button, card: game.cardsOnScreen[item])
            } else {
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
        }
    }


    func paintCard(button: UIButton, card: Card) {
        if card.isMatched {
            button.backgroundColor = UIColor.clear
            return
        }

        if card.isSelected {
            button.layer.borderWidth = 3.0
            button.layer.borderColor = UIColor.blue.cgColor
            button.layer.cornerRadius = 8.0
        }

        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        var text = ""
        var color = UIColor.black
        var alpha: CGFloat = 0.0
        var attributes: [NSAttributedStringKey: Any] = [:]

        switch card.shape {
        case .diamond:
            text = "▲"
        case .oval:
            text = "●"
        case .squiggle:
            text = "■"
        }

        switch card.number {
        case .one:
            break
        case .two:
            text += text
        case .three:
            text = text + text + text
        }

        switch card.color {
        case .green:
            color = UIColor.green
        case .purple:
            color = UIColor.purple
        case .red:
            color = UIColor.red
        }

        switch card.shading {
        case .open:
            alpha = 0.5
            attributes[.strokeWidth] = 5
        case .solid:
            alpha = 1
        case .striped:
            alpha = 0.15
        }

        attributes[.foregroundColor] = color.withAlphaComponent(alpha)
        let attributedString = NSAttributedString(string: text + "\n", attributes: attributes)
        button.setAttributedTitle(attributedString, for: .normal)
    }

    @IBAction func newGame() {
        game = SetGame()
        updateView()

    }

    @IBAction func deal3MoreCards() {
        game.deal3moreCards()
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

