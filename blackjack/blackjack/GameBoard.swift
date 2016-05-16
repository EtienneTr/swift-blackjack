//
//  GameBoard.swift
//  blackjack
//
//  Created by Supinfo on 13/05/16.
//  Copyright © 2016 EtienneTR. All rights reserved.
//

import Foundation

//Action Player
enum actionType: Int {
    case Hit = 1, Stay, Surrender, DoubleDown, Split, Insure
}

class Game {
    var currShoe : [Cards]
    
    //Hand player and dealer
    var PlayersHands : [PlayerHand] = []
    var Dealerhand : DealerHand = DealerHand()
    var SplitStatus = 0 //0 : no split, 1: split first hand,  2: split second
    var redCardPresent = false // to signal presence of red card
    
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
        //move all cards before the blue card to the end of the deck
        for _ in 0..<index {
            tmp = currShoe[0]
            currShoe.removeFirst()
            currShoe.append(tmp)
        }
        print("Premiere carte du paquet apres coupage: ", currShoe[0].type!)
        
        //randomly (at least 30 cards after the blue card) put red card in the deck
        let redCard = Cards()
        currShoe.insert(redCard, atIndex: Int(arc4random_uniform(250)+30))
        
        //reset to false
        redCardPresent = false
        
        //remove first 5 cards of the deck
        for _ in 1...5 {
            currShoe.removeFirst()
        }
        
        
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
            
            if i > 4 {
                i = 0
            }
            
            card = self.currShoe.first!
            self.currShoe.removeFirst()
            
            if i == 0 {
                self.Dealerhand.addCards(card)
            }else{
                self.PlayersHands[i - 1].addCards(card)
            }
            i+=1
        }
        
        for card in Dealerhand.HandCard{
            if card.type != nil
            {
                print(card.type!, " & ", card.suit!)
            }
            else { print("REEEEEED") }
        }
        
    }
    
    func checkRedCard()->Cards{
        var card = currShoe.removeFirst()
        if card.type == nil {
            redCardPresent = true
            card = currShoe.removeFirst()
        }
        return card
    }
    
    func checkActions(player: PlayerHand, action: actionType)->Bool{

        
        let card = checkRedCard()
        
        
        // juste pour tester *******
        /*PlayersHands[0].halveStakes()
        print(PlayersHands[0].stakes!.White)
        print(PlayersHands[0].stakes!.Red)
        print(PlayersHands[0].stakes!.Green)
        print(PlayersHands[0].stakes!.Blue)*/
        // *********
        
        switch(action){
        case .Hit:
            if SplitStatus == 0 {
                player.addCards(card)
                if !checkScore(player) { endRound() }
                return (checkScore(player))
            }
            else if SplitStatus == 1 {
                player.addCards(card)
                if !checkScore(player) { SplitStatus = 2 }
                return(checkScore(player))
            }
            else if SplitStatus == 2 {
                player.secondHand?.addCards(card)
                if !checkScore(player.secondHand!) { endRound() }
                return(checkScore(player.secondHand!))
            }
        case .Stay:
            //split : goto hand 2
            if(SplitStatus == 1){
                SplitStatus = 2;
                return true
            } else if (SplitStatus == 2){
                SplitStatus = 0
                endRound()
                return false
                //END game
                endRound()
                updateChips(player)
                
            }
            break
        case .Surrender:
            player.surrender()
            return (false)
        case .DoubleDown:
            player.doubleDown()
            player.addCards(card)
            return(false)
        case .Split:
            player.split()
            if(SplitStatus == 0){
                SplitStatus = 1//start first split
            }
            return(true)
        case .Insure:
            player.insure()
            return(true)
        }
        return(false)
    }
    
    
    
    func checkScore(player: PlayerHand)->Bool{
        return(player.sumCards()<21)
    }
    
    func endRound()->Bool {
        // returns true if cards need to be reshuffled ( remelanger, couper etc )
        //TODO : IF WIN
        
        //dealer hits until 17
        while Dealerhand.sumCards() < 17 {
            let card = checkRedCard()
            Dealerhand.addCards(card)
        }
        
        var player = PlayersHands[0]
        //check if player has won
            
        if player.sumCards() <= 21 && (Dealerhand.sumCards() > 21 || player.sumCards() > Dealerhand.sumCards()) {
            player.status = 2 //player won
        }
        else if player.sumCards() == Dealerhand.sumCards(){
            player.status = 1 //tie
        }
        else {
            player.status = 0 //player lost
        }
        
        updateChips(player)
        
        //reset player hand 
        player.HandCard = []

        return redCardPresent
    }

    func updateChips(player: PlayerHand){
        if Dealerhand.sumCards() == 21 && player.insured == true {
            player.returnInsurance()
        }
        if player.status == 1 {
            player.returnStakes()
        }
        else if player.status == 2 {
            player.winChips()
        }
        else if player.status == 3 {
            player.winChips(true)
        }
    }
    
    
}
