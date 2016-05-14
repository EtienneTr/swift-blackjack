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
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
