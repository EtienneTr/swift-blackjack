//
//  Shoe.swift
//  blackjack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 EtienneTR. All rights reserved.
//

import Foundation

//CLASS SHOE : Sabot
class Shoe {
    var gameShoe : [Cards] = []
    
    init(){
        
        //312 cartes = 6 fois un jeux de 52
        for _ in 0..<6{
            for suits in 1...4{// un jeu de 52 = chaque suite avec tous les types
                for type in 1...13{//12 type
                    
                    let card = Cards(_type: cardType(rawValue: type)!, _suit: cardSuits(rawValue: suits)!)
                    gameShoe.append(card);
                }
            }
            
        }
        /*
        for card in gameShoe{
        print(card.type, " & ", card.suit);
        }
        print(gameShoe.count)*/
        
        //mélange aléatoire : on prend 2 index aléatoire qu'on trie, 312 fois
        for _ in 0..<312{
            gameShoe.sortInPlace { (_,_) in arc4random() < arc4random() }
        }
        
        for card in gameShoe{
            print(card.type, " & ", card.suit);
        }
        print(gameShoe.count)
        
    }
    
}