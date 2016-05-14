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
    
    //Add cards
    func addCards(card : Cards){
        HandCard.append(card)
    }
    
    
    
}


class PlayerHand : Hand {
    var HandChips : Chips
    var out : Bool = false
    var double : Bool = false
    var secondHand : PlayerHand?
    var stakes : Chips?    //la mise
    
    //init user with chips
    override init(){
        self.HandChips = Chips(nbBlue: 15,nbGreen: 15,nbRed: 15,nbWhite: 15,nbBlack: 15)
    }
    
    func bet(nbBlue : Int, nbGreen : Int, nbRed : Int, nbWhite : Int, nbBlack : Int){
        stakes = Chips(nbBlue: nbBlue, nbGreen: nbGreen, nbRed: nbRed, nbWhite: nbWhite, nbBlack: nbBlack)
    }
    
    //player stays
    func stay() -> Bool {
        return true
    }
    
    //player surrenders, takes back half his stakes
    func surrender() {
        out = true
        halveStakes()
    }
    
    //double the stakes
    func doubleDown() {
        double = true
        doubleStakes()
    }
    
    //player has a double, splits his hand into two hands
    func split() {
        secondHand = PlayerHand()
        secondHand!.stakes = self.stakes
    }
    
    //player has 9,10 or 11, double his stakes
    func doubleStakes() {
        stakes!.double()
    }
    
    //divide stakes by 2
    func halveStakes() {
        stakes!.halve()
    }
}

class DealerHand : Hand {
    var isDealer : Bool
    
    override init(){
        self.isDealer = true
    }
}