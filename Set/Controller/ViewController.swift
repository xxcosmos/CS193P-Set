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



    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var deal3MoreCardButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var cardContainerView: CardContainerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(didPressDeal3MoreCardButton))
        swipe.direction = [.down]
        deal3MoreCardButton.addGestureRecognizer(swipe)
        
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(shuffleCard))
        cardContainerView.addGestureRecognizer(rotation)
    }
    @objc func shuffleCard() {
        game.shuffle()
        viewInit()
    }
    
    @objc func tapCard(tap: UITapGestureRecognizer) {
        let cardView = tap.view
        
        let index = cardContainerView.cards.index(of: cardView as! CardView)!
        game.cardStateChanged(card: game.cardsOnScreen[index])
        viewInit()
    }
    
    private func viewInit() {
        cardContainerView.clearCardContainer()
        cardContainerView.addCardIntoView(amount: game.cardsOnScreen.count)
        for card in cardContainerView.cards {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapCard(tap:)))
            card.addGestureRecognizer(tap)
        }
        displayView()
    }
    
    @IBAction func didPressNewGameButton(_ sender: UIButton) {
         game = SetGame()
         viewInit()
    }
    
    @IBAction func didPressDeal3MoreCardButton() {
        for _ in 1...3 {
            game.drawCard(isAdd: true, index: 0)
        }
        viewInit()
    }
    
    private func displayView() {
        for (index,cardView) in cardContainerView.cards.enumerated() {
            let card = game.cardsOnScreen[index]
            cardView.card = card
            
            if card.isSelected {
                cardView.layer.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            }
            if card.isMatched {
                cardView.layer.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0)
            }
        }
        
        scoreLabel.text = "Score: \(game.score)"
        
        deal3MoreCardButton.isEnabled = game.canAddMoreCards
    }
}

