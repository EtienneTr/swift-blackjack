//
//  GameViewController.swift
//  blackjack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 EtienneTR. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    var IndexBlueCard = 0;
    var game = Game()
    var textView2 = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Début de la partie"
        //init game
        //game = Game();
        //init shoe
         
        game.createShoe(IndexBlueCard);
        //init hand
        game.initHands();
        //bet alert
        AlertBetOnGameStart();
        initSplitView();
        //disable actions not allowed all time
        UIDisabledNotAllowed()
        
        //game.PlayersHands[0].HandCard[0].type = .EIGHT
        //game.PlayersHands[0].HandCard[1].type = .TWO
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet var UserScore: UILabel!
    func UIupdateScore(){
        UserScore.text = String(game.PlayersHands[0].sumCards())
    }
    
    @IBOutlet var AllChipsView: UIView!
    func UIDisabledNotAllowed(){
        DoubleButton.enabled = false
        DoubleButton.hidden = true
        SplitButton.enabled = false
        SplitButton.hidden = true
        InsurButton.enabled = false
        InsurButton.hidden = true
    }
    
    //BET ALERT ACTIONS
    @IBOutlet var BlueField: UITextField!
    @IBOutlet var GreenField: UITextField!
    @IBOutlet var RedField: UITextField!
    @IBOutlet var WhiteField: UITextField!
    func AlertBetOnGameStart(){
        
        func betEntered(alert: UIAlertAction!){
            // store the new word
            self.textView2.text = self.BlueField.text!
            
            //Bet user
            game.PlayersHands[0].bet(Int(BlueField.text!), nbGreen: Int(GreenField.text!), nbRed: Int(RedField.text!), nbWhite: Int(WhiteField.text!))
            
            //start game
            startUIGame()
        }
        
        // display an alert
        let newWordPrompt = UIAlertController(title: "Bet before start", message: "Blue, Red, Green, White", preferredStyle: UIAlertControllerStyle.Alert)
        newWordPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Blue Chips"
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.delegate = self
            self.BlueField = textField
        })
        newWordPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Green Chips"
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.delegate = self
            self.GreenField = textField
        })
        newWordPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Red Chips"
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.delegate = self
            self.RedField = textField
        })
        newWordPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "White Chips"
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.delegate = self
            self.WhiteField = textField
        })
        newWordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: betEntered))
        presentViewController(newWordPrompt, animated: true, completion: nil)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = NSCharacterSet(charactersInString: "0123456789").invertedSet
        return string.rangeOfCharacterFromSet(invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
    
    //init cards and Actions allowed
    func startUIGame(){
        initFirstDrawView(game.Dealerhand, players: game.PlayersHands)
        
        //Check User Actions & enable allowed
        let userCards = game.PlayersHands[0].HandCard
        
        //same type (même valeur) : split allowed
        if(userCards[0].type == userCards[1].type){
            SplitButton.hidden = false
            SplitButton.enabled = true
        }
        
        //If sum between 9 & 11 : double allowed
        let sumCards = game.PlayersHands[0].sumCards()
        if case 9...11 = sumCards{
            DoubleButton.hidden = false
            DoubleButton.enabled = true
        }
        
        //Insurance if dealer have AS
        if (game.Dealerhand.HandCard[0].type == cardType.ACE){
            InsurButton.enabled = true
            InsurButton.hidden = false
        }
        
        //after bet : update chips
        updateTotalChips()
        updateBetChips()
        
        //score
        UIupdateScore()
        
        //blackjack
        if(game.PlayersHands[0].sumCards() == 21){
            game.PlayersHands[0].status = 3
            game.endRound()
            UIEndAction()
        }
        //place chips
        // self.view.addConstraint(NSLayoutConstraint(item: AllChipsView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        //)
        //self.view.layoutIfNeeded()
    }   
    
    
    //Game Cards
    @IBOutlet var DealerCard1: UILabel!
    @IBOutlet var DealerCard2: UILabel!
    @IBOutlet var DealerCard3: UILabel!
    @IBOutlet var DealerCard4: UILabel!

    @IBOutlet var UserCard1: UILabel!
    @IBOutlet var UserCard2: UILabel!
    
    @IBOutlet var Player1Card1: UILabel!
    @IBOutlet var Player1Card2: UILabel!
    @IBOutlet var Player2Card1: UILabel!
    @IBOutlet var Player2Card2: UILabel!
    @IBOutlet var Player4Card1: UILabel!
    @IBOutlet var Player4Card2: UILabel!
    
    
    func initFirstDrawView(dealer : DealerHand, players : [PlayerHand]){
        DealerCard1.text = String(dealer.HandCard[0].type!) + " " + String(dealer.HandCard[0].suit!)
        
        //DealerCard2.text = String(dealer.HandCard[1].type!) + " " + String(dealer.HandCard[1].suit!)
        
        UserCard1.text = String(players[0].HandCard[0].type!) + " " + String(players[0].HandCard[0].suit!)
        UserCard2.text = String(players[0].HandCard[1].type!) + " " + String(players[0].HandCard[1].suit!)
        
        Player1Card1.text = String(players[1].HandCard[0].type!) + " " + String(players[1].HandCard[0].suit!)
        Player1Card2.text = String(players[1].HandCard[1].type!) + " " + String(players[1].HandCard[1].suit!)
        
        Player2Card1.text = String(players[2].HandCard[0].type!) + " " + String(players[2].HandCard[0].suit!)
        Player2Card2.text = String(players[2].HandCard[1].type!) + " " + String(players[2].HandCard[1].suit!)
        
        //Player4Card1.text = String(players[3].HandCard[0].type!) + " " + String(players[3].HandCard[0].suit!)
        //Player4Card2.text = String(players[3].HandCard[1].type!) + " " + String(players[3].HandCard[1].suit!)
    }
    
    func discoverDealerCard(){
        DealerCard2.text = String(game.Dealerhand.HandCard[1].type!) + " " + String(game.Dealerhand.HandCard[1].suit!)
        
        //more cards
        if(game.Dealerhand.HandCard.count > 2){
            DealerCard3.text = String(game.Dealerhand.HandCard[2].type!) + " " + String(game.Dealerhand.HandCard[2].suit!)
            DealerCard3.hidden = false
        }
        if(game.Dealerhand.HandCard.count > 3){
            DealerCard4.text = String(game.Dealerhand.HandCard[3].type!) + " " + String(game.Dealerhand.HandCard[3].suit!)
            DealerCard4.hidden = false
        }
    }
    
    //SPLIT : CARDS - VIEWS
    @IBOutlet var HandSplit1View: UIView!
    @IBOutlet var HandSplit2View: UIView!
    
    @IBOutlet var UserCard11: UILabel!
    @IBOutlet var UserCard13: UILabel!
    @IBOutlet var UserCard14: UILabel!
    @IBOutlet var UserSplit1Label: UILabel!
    
    @IBOutlet var UserCard22: UILabel!
    @IBOutlet var UserCard23: UILabel!
    @IBOutlet var UserCard24: UILabel!
    @IBOutlet var UserSplit2Label: UILabel!
    
    func initSplitView(){
        //hide labels & split cards
        UserCard11.hidden = true
        UserCard11.text = ""
        UserCard13.hidden = true
        UserCard13.text = ""
        UserCard14.hidden = true
        UserCard14.text = ""
        UserSplit1Label.hidden = true
        
        UserCard22.hidden = true
        UserCard22.text = ""
        UserCard23.hidden = true
        UserCard23.text = ""
        UserCard24.hidden = true
        UserCard24.text = ""
        UserSplit2Label.hidden = true
    }
    
    //ACTIONS USER : click buttons
    @IBOutlet var StayButton: UIButton!
    
    @IBOutlet var HitButton: UIButton!
    @IBOutlet var DoubleButton: UIButton!
    @IBOutlet var SplitButton: UIButton!
    @IBOutlet var SurrButton: UIButton!
    @IBOutlet var InsurButton: UIButton!
    
    @IBAction func OnStayAction(sender: UIButton) {
        print("stay")
        var lastSplit = false
        //disable split
        if(game.SplitStatus == 2){
            lastSplit = true
        }
        game.checkActions(game.PlayersHands[0], action: .Stay)
        
        //enable split
        if(game.SplitStatus == 1 || game.SplitStatus == 2 || lastSplit){
            UISplit()
            lastSplit = false
        }else{
            //end
            UIEndAction()
        }
        
        if(lastSplit){
            UIEndAction()
        }
    }
    
    @IBAction func OnHitAction(sender: UIButton) {
        print("hit")
        //hit first or second hand
        var result : Bool
        switch(game.SplitStatus){
        case 1:
            print("1")
            result = game.checkActions(game.PlayersHands[0], action: .Hit)
            UISplit()
            break
        case 2:
            result = game.checkActions(game.PlayersHands[0].secondHand!, action: .Hit)
            UISplit()
            break
        default:
            result = game.checkActions(game.PlayersHands[0], action: .Hit)
            UIHit()
            break

        }
        
        if (result == false){
            UIEndAction()
        }

    }
    
    @IBAction func OnDoubleAction(sender: UIButton) {
        print("Double")
        game.checkActions(game.PlayersHands[0], action: .DoubleDown)
        
        //update cards & RAW
        UIHit()
        updateBetChips()
        //End
        UIEndAction()
    }
    
    @IBAction func OnSplitAction(sender: UIButton) {
        print("split")
        
        game.checkActions(game.PlayersHands[0], action: .Split)
        //first SplitUI Action
        UISplit()
        
    }
    
    @IBAction func OnSurrAction(sender: UIButton) {
        print("Surrender")
        game.checkActions(game.PlayersHands[0], action: .Surrender)
        UIEndAction()
    }
    
    @IBAction func OnInsurAction(sender: UIButton) {
        print("Insurance")
        game.checkActions(game.PlayersHands[0], action: .Insure)
    }
    
    func UISplit(){
        
        //disable button
        UIDisabledNotAllowed()
        
        switch(game.SplitStatus){
        case 0:
            HandSplit1View.layer.borderWidth = 0
            HandSplit2View.layer.borderWidth = 0
            initSplitView()
            break
        case 1:
            if(game.PlayersHands[0].HandCard.count == 1){
                //first hand hightlight
                HandSplit1View.layer.cornerRadius = 10
                HandSplit1View.layer.borderWidth = 2
                HandSplit1View.layer.borderColor = UIColor.lightGrayColor().CGColor
                UserSplit1Label.text = "Hand 1"
                UserSplit1Label.hidden = false
            }else{
                
            //first hand : Hit
            let card = game.PlayersHands[0].HandCard.last!
            let text = String(card.type!) + " " + String(card.suit!)
            print(text)
            print(UserCard11.text)
            if(UserCard11.text == ""){
                UserCard11.text = text
                UserCard11.hidden = false
            } else if (UserCard13.text == ""){
                UserCard13.text = text
                UserCard13.hidden = false
            } else {
                UserCard14.text = text
                UserCard14.hidden = false
            }
                
                UserSplit1Label.text = "Hand 1 score : " + String(game.PlayersHands[0].sumCards())
                
            }
            break
        case 2:
            
            if(game.PlayersHands[0].secondHand?.HandCard.count == 1){
                //hightlight
                HandSplit2View.layer.cornerRadius = 10
                HandSplit2View.layer.borderWidth = 2
                HandSplit2View.layer.borderColor = UIColor.lightGrayColor().CGColor
                UserSplit2Label.text = "Hand 2"
                UserSplit2Label.hidden = false
                
                //disable split 1
                HandSplit1View.layer.borderWidth = 0
            }else{
            
            //second hand Hit
            let card = game.PlayersHands[0].secondHand!.HandCard.last!
            let text = String(card.type!) + " " + String(card.suit!)
            
            if(UserCard22.text == ""){
                UserCard22.text = text
                UserCard22.hidden = false
            } else if (UserCard23.text == ""){
                UserCard23.text = text
                UserCard23.hidden = false
            } else {
                UserCard24.text = text
                UserCard24.hidden = false
            }
                
                UserSplit1Label.text = "Hand 2 score : " + String(game.PlayersHands[0].secondHand!.sumCards())
            }
            break
        default:
            break
        }
    }
    
    func UIHit(){
        if(game.PlayersHands[0].HandCard.count > 0){
            let card = game.PlayersHands[0].HandCard.last!
            let text = String(card.type!) + " " + String(card.suit!)
        
            if(UserCard11.text == ""){
                UserCard11.text = text
                UserCard11.hidden = false
            } else if (UserCard22.text == ""){
                UserCard22.text = text
                UserCard22.hidden = false
            } else if (UserCard13.text == ""){
                UserCard13.text = text
                UserCard13.hidden = false
            } else if (UserCard23.text == ""){
                UserCard23.text = text
                UserCard23.hidden = false
            } else if (UserCard14.text == ""){
                UserCard14.text = text
                UserCard14.hidden = false
            } else if (UserCard24.text == ""){
                UserCard24.text = text
                UserCard24.hidden = false
            }
        
            //score
            UIupdateScore()
        }

    }
    
    //OUTLET + UPDATE TOTAL CHIPS
    @IBOutlet var TotalBlueChips: UILabel!
    @IBOutlet var TotalWhiteChips: UILabel!
    @IBOutlet var TotalGreenChips: UILabel!
    @IBOutlet var TotalRedChips: UILabel!
    
    func updateTotalChips(){
        let blue = self.game.PlayersHands[0].HandChips.Blue
        TotalBlueChips.text = String(blue)
        let green = self.game.PlayersHands[0].HandChips.Green
        TotalGreenChips.text = String(green)
        let red = self.game.PlayersHands[0].HandChips.Red
        TotalRedChips.text = String(red)
        let white = self.game.PlayersHands[0].HandChips.White
        TotalWhiteChips.text = String(white)
    }
    
    
    //OUTLET + UPDATE BET CHIPS
    @IBOutlet var BetBlueChips: UILabel!
    @IBOutlet var BetRedChips: UILabel!
    @IBOutlet var BetGreenChips: UILabel!
    @IBOutlet var BetWhiteChips: UILabel!
    
    func updateBetChips(){
        let blue = self.game.PlayersHands[0].stakes!.Blue
        BetBlueChips.text = String(blue)
        let green = self.game.PlayersHands[0].stakes!.Green
        BetGreenChips.text = String(green)
        let red = self.game.PlayersHands[0].stakes!.Red
        BetRedChips.text = String(red)
        let white = self.game.PlayersHands[0].stakes!.White
        BetWhiteChips.text = String(white)
    }
    
    //END ACTION
    @IBOutlet var IndexBlue: UITextField!
    
    func UIEndAction(){
        discoverDealerCard()
        updateBetChips()
        updateTotalChips()
        
        var text = ""
        if(game.PlayersHands[0].status == 0){
            text = "You loose the round :("
        }else if (game.PlayersHands[0].status == 1){
            //tie
            text = "It's a tie !"
        }else if (game.PlayersHands[0].status == 1){
            //win
            text = "You win the round"
        }else{
            //blackjack
        }
        
        text += "\n Your point : " + String(game.PlayersHands[0].sumCards()) + "\n Dealer point : " + String(game.Dealerhand.sumCards())
        let newWordPrompt = UIAlertController(title: "Game message", message: text, preferredStyle: UIAlertControllerStyle.Alert)
        
        newWordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: callbackAlertEndGame))
        presentViewController(newWordPrompt, animated: true, completion: nil)

    }
    
    func callbackAlertEndGame(alert: UIAlertAction!) {
        resetUI()
        game.NewGame()
        if(game.redCardPresent){
            //reset : new Blue Index
            let indexBlue = UIAlertController(title: "Index blue card", message: "Chosse blue card position (5 - 310)", preferredStyle: UIAlertControllerStyle.Alert)
            indexBlue.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
                textField.placeholder = "Blue Chips"
                textField.keyboardType = UIKeyboardType.NumberPad
                textField.delegate = self
                self.IndexBlue = textField
            })
            
            indexBlue.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: ResetGame))
            presentViewController(indexBlue, animated: true, completion: nil)
        }else{
            //new round
            game.initHands();
            AlertBetOnGameStart();
            initSplitView();
            UIDisabledNotAllowed();
        }
    }
    
    func resetUI(){
        //reset split
        initSplitView()
        
        //reset dealer card
        DealerCard2.text = "Card 2"
        DealerCard3.hidden = true
        DealerCard4.hidden = true
        
        //reset cards
        
    }
    
    func ResetGame(alert: UIAlertAction!){
        
        
        if (IndexBlue.text == ""){
            IndexBlue.text = "0"
        }
        
        IndexBlueCard = Int(IndexBlue.text!)!
        
        //new game
        //self.game = Game()
        game.createShoe(IndexBlueCard);
        //init hand
        game.initHands();
        //bet alert
        AlertBetOnGameStart();
        initSplitView();
        //disable actions not allowed all time
        UIDisabledNotAllowed()
    }
}
