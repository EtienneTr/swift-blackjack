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
    
    //sum player hand cards
    func sumCards() -> Int{
        var sum = 0
        for card in HandCard{
            sum += card.nbrValue
        }
        return sum
    }
    
}


class PlayerHand : Hand {
    var HandChips : Chips
    var out : Bool = false
    var double : Bool = false
    var secondHand : PlayerHand?
    var stakes : Chips?    //la mise
    var insurance: Chips?
    var insured: Bool = false
    
    //init user with chips
    override init(){
        self.HandChips = Chips(nbBlue: 15,nbGreen: 15,nbRed: 15,nbWhite: 15)
    }
    
    func bet(var nbBlue : Int?, var nbGreen : Int?, var nbRed : Int?, var nbWhite : Int?){
        if(nbBlue == nil){
            nbBlue = 0
        }
        if(nbGreen == nil){
            nbGreen = 0
        }
        if(nbRed == nil){
            nbRed = 0
        }
        if(nbWhite == nil){
            nbWhite = 0
        }
        stakes = Chips(nbBlue: nbBlue!, nbGreen: nbGreen!, nbRed: nbRed!, nbWhite: nbWhite!)
        HandChips.Blue -= nbBlue!
        HandChips.Green -= nbGreen!
        HandChips.Red -= nbRed!
        HandChips.White -= nbWhite!
    }
    
    //player stays
    func stay() -> Bool{
        return true
    }
    
    //player surrenders, takes back half his stakes
    func surrender(){
        out = true
        halveStakes()
    }
    
    //double the stakes
    func doubleDown(){
        double = true
        doubleStakes()
    }
    
    //player has a double, splits his hand into two hands
    func split(){
        secondHand = PlayerHand()
        secondHand!.stakes = self.stakes
    }
    
    //player takes insurance worth half his stakes if dealer has an ace
    func insure(){
        insurance = stakes
        insurance!.halve()
        insured = true
    }
    
    //player has 9,10 or 11, double his stakes
    func doubleStakes(){
        stakes!.double()
    }
    
    //divide stakes by 2
    func halveStakes(){
        stakes!.halve()
    }
    
    //changes Ace value depending on user choice 
    func changeAceValue(value: Int){
        let count = HandCard.count
        for i in 0...count{
            if HandCard[i].type! == cardType.ACE{
                HandCard[i].nbrValue = value
            }
        }
    }
    
}

class DealerHand : Hand {
    var isDealer : Bool
    
    override init(){
        self.isDealer = true
    }
}