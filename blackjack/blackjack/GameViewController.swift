//
//  GameViewController.swift
//  blackjack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 EtienneTR. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    var IndexBlueCard = 20;
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Début de la partie"
        
        //init game
        //game = Game();
        //init shoe
        game.createShoe(IndexBlueCard);
        //init hand and draw
        game.initHands();
        
        initFirstDrawView(game.Dealerhand, players: game.PlayersHands)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Game Cards
    @IBOutlet var DealerCard1: UILabel!
    @IBOutlet var DealerCard2: UILabel!

    @IBOutlet var UserCard1: UILabel!
    @IBOutlet var UserCard2: UILabel!
    
    @IBOutlet var Player1Card1: UILabel!
    @IBOutlet var Player1Card2: UILabel!
    @IBOutlet var Player2Card1: UILabel!
    @IBOutlet var Player2Card2: UILabel!
    @IBOutlet var Player4Card1: UILabel!
    @IBOutlet var Player4Card2: UILabel!
    
    
    func initFirstDrawView(dealer : DealerHand, players : [PlayerHand]){
        DealerCard1.text = String(dealer.HandCard[0].type!) + " " + String(dealer.HandCard[0].suit!)
        
        DealerCard2.text = String(dealer.HandCard[1].type!) + " " + String(dealer.HandCard[1].suit!)
        
        UserCard1.text = String(players[0].HandCard[0].type!) + " " + String(players[0].HandCard[0].suit!)
        UserCard2.text = String(players[0].HandCard[1].type!) + " " + String(players[0].HandCard[1].suit!)
        
        Player1Card1.text = String(players[1].HandCard[0].type!) + " " + String(players[1].HandCard[0].suit!)
        Player1Card2.text = String(players[1].HandCard[1].type!) + " " + String(players[1].HandCard[1].suit!)
        
        Player2Card1.text = String(players[2].HandCard[0].type!) + " " + String(players[2].HandCard[0].suit!)
        Player2Card2.text = String(players[2].HandCard[1].type!) + " " + String(players[2].HandCard[1].suit!)
        
        Player4Card1.text = String(players[3].HandCard[0].type!) + " " + String(players[3].HandCard[0].suit!)
        Player4Card2.text = String(players[3].HandCard[1].type!) + " " + String(players[3].HandCard[1].suit!)
    }
}
