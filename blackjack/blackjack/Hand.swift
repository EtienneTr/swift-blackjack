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
    var status: Int = 0 // 0 = lose, 1 = tie, 2 = win
    
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
        returnStakes()
    }
    
    //double the stakes
    func doubleDown(){
        double = true
        doubleStakes()
    }
    
    //player has a double, splits his hand into two hands
    func split(){
        secondHand = PlayerHand()
        secondHand!.addCards(self.HandCard[1])
        self.HandCard.removeLast()
        secondHand!.stakes = self.stakes
    }
    
    //player takes insurance worth half his stakes if dealer has an ace
    func insure(){
        insurance = stakes
        insurance!.halve()
        HandChips.Blue -= insurance!.Blue
        HandChips.Green -= insurance!.Green
        HandChips.Red -= insurance!.Red
        HandChips.White -= insurance!.White
        insured = true
    }
    
    //player has 9,10 or 11, double his stakes
    func doubleStakes(){
        stakes!.double()
    }

    func halveStakes(){
        stakes!.halve()
    }
    
    func returnStakes(){
        HandChips.Blue += stakes!.Blue
        HandChips.Green += stakes!.Green
        HandChips.Red += stakes!.Red
        HandChips.White += stakes!.White
    }
    
    func winChips(blackjack: Bool = false){
        if blackjack == false {
            HandChips.Blue += stakes!.Blue*2
            HandChips.Green += stakes!.Green*2
            HandChips.Red += stakes!.Red*2
            HandChips.White += stakes!.White*2
        }
        else if blackjack == true {
            HandChips.Blue += Int(floor(Double(stakes!.Blue) * 1.5))
            HandChips.Green += Int(floor(Double(stakes!.Green) * 1.5))
            HandChips.Red += Int(floor(Double(stakes!.Red) * 1.5))
            HandChips.White += Int(floor(Double(stakes!.White) * 1.5))
        }
    }
    
    func returnInsurance(){
        HandChips.Blue += insurance!.Blue*2
        HandChips.Green += insurance!.Green*2
        HandChips.Red += insurance!.Red*2
        HandChips.White += insurance!.White*2
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