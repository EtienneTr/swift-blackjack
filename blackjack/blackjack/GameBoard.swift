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
    
    //Hand player and dealer
    var PlayersHands : [PlayerHand] = []
    var Dealerhand : DealerHand = DealerHand()
    
    init(){
        //init Shoe
        self.currShoe = Shoe().gameShoe;
        startGame();
    }
    
    
    func startGame() {
        //blue card
        
        print("Choisissez une carte entre 1 et 312, pour placer la carte bleu");
        //myInput = numéro de carte, on met la bleu après
        //createShoe(45)
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
    
    //Draw Cards
    func initHands() {
        for _ in 0..<4{
            PlayersHands.append(PlayerHand())
        }
        //PlayerHands 
        //[0] = Current User Hand
        //[1...3] = Player 1 to 4 Hand
        
        //DRAW : les 10 premières cartes
        var i = 0;
        var card : Cards
        
        for _ in 0..<10{
            
            if (i > 4){
                i = 0;
            };
            
            card = self.currShoe.first!
            self.currShoe.removeFirst()
            
            if(i == 0){
                self.Dealerhand.addCards(card)
            }else{
                self.PlayersHands[i - 1].addCards(card)
            }
            i+=1
        }
        
        for card in Dealerhand.HandCard{
            if(card.type != nil)
            {
                print(card.type!, " & ", card.suit!);
            }
            else { print("REEEEEED") }
        }
        
    }
}