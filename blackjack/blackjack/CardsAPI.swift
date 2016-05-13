//
//  Cards.swift
//  blackjack
//
//  Created by Supinfo on 12/05/16.
//  Copyright © 2016 EtienneTR. All rights reserved.
//

import Foundation

//CARD SUITS = couleur
enum cardSuits: Int {
    case Diamonds = 1, Spades, Clubs, Hearts
}

//CARD TYPE = valeur
enum cardType : Int{
    case AS = 1, KNAVE, QUEEN, KING, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, THEN
}

//CLASS CARDS
class Cards {
    var type : cardType
    var nbrValue : Int = 0 //valeur de la carte dans le jeu.
    var suit : cardSuits
    
    init(_type: cardType, _suit: cardSuits){
        self.type = _type;
        self.suit = _suit;
        self.nbrValue = getScore(_type);
        
    }
    
    func getScore(type: cardType) -> Int{
        switch(type){
            case .AS:
                return 11
            case .KNAVE, .QUEEN, .KING, .THEN:
                return 10;
            case .NINE:
                return 9;
            case .EIGHT:
                return 8;
            case .SEVEN:
                return 7;
            case .SIX:
                return 6;
            case .FIVE:
                return 5;
            case .FOUR:
                return 4;
            case .THREE:
                return 3;
            case .TWO:
                return 2;
            
        }
    }
}

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
