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
    case AS = 1, KNAVE, QUEEN, KING, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN
}

//CLASS CARDS
class Cards {
    var type : cardType?
    var nbrValue : Int = 0 //valeur de la carte dans le jeu.
    var suit : cardSuits?
    var red : Bool
    
    init(_type: cardType, _suit: cardSuits){
        self.type = _type
        self.suit = _suit
        self.red = false
        self.nbrValue = getScore(_type)
        
    }
    
    init(){
        self.red = true
    }
    
    func getScore(type: cardType) -> Int{
        switch(type){
        case .AS:
            return 11
        case .KNAVE, .QUEEN, .KING, .TEN:
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
