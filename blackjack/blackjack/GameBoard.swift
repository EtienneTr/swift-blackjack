//
//  GameBoard.swift
//  blackjack
//
//  Created by Supinfo on 13/05/16.
//  Copyright © 2016 EtienneTR. All rights reserved.
//

import Foundation


class Game {
    var currShoe : [Cards]
    
    init(){
        //init Shoe
        self.currShoe = Shoe().gameShoe;
        startGame();
    }
    
    
    func startGame() {
        //blue card
        
        print("Choisissez une carte entre 1 et 312, pour placer la carte bleu");
        //myInput = numéro de carte, on met la bleu après
        createShoe(45)
    }
    
    func createShoe(index: Int) {
        var tmp : Cards
        print("Premiere carte apres carte bleu: ", currShoe[index].type!)
        for _ in 0..<index {
            tmp = currShoe[0]
            currShoe.removeFirst()
            currShoe.append(tmp)
        }
        print("Premiere carte du paquet apres coupage: ", currShoe[0].type!)
        let redCard = Cards()
        currShoe.insert(redCard, atIndex: Int(arc4random_uniform(250)+30))
        for card in currShoe{
            if(card.type != nil)
            {
            print(card.type!, " & ", card.suit!);
            }
            else { print("REEEEEED") }
        }
        print(currShoe.count)
    }
}