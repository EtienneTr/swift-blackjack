//
//  Hand.swift
//  blackjack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 EtienneTR. All rights reserved.
//

import Foundation

//la main d'un joueur :
class Hand {
    
    var HandCard : [Cards] = []
    
    init() {}
    
    //if split; HandCard = first split, SplitCard = second split
    var SplitCard : [Cards] = []
    
    
    //Add cards
    func addCards(card : Cards){
        HandCard.append(card)
    }
}

class PlayerHand : Hand {
    var HandChips : Chips
    
    //init user with chips
    override init(){
        self.HandChips = Chips(nbBlue: 15,nbGreen: 15,nbRed: 15,nbWhite: 15,nbBlack: 15)
    }
}

class DealerHand : Hand {
    var isDealer : Bool
    
    override init(){
        self.isDealer = true
    }
}