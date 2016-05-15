//
//  GameViewController.swift
//  blackjack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 EtienneTR. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    var IndexBlueCard = 20;
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
        
        //disable actions not allowed all time
        UIDisabledNotAllowed()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            game.PlayersHands[0].bet(Int(BlueField.text!), nbGreen: Int(GreenField.text!), nbRed: Int(RedField.text!), nbWhite: Int(RedField.text!))
            
            //start game
            startUIGame()
        }
        
        // display an alert
        let newWordPrompt = UIAlertController(title: "Bet before start", message: "Blue, Red, Green, White", preferredStyle: UIAlertControllerStyle.Alert)
        newWordPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Blue Chips"
            textField.keyboardType = UIKeyboardType.NumberPad
            self.BlueField = textField
        })
        newWordPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Green Chips"
            textField.keyboardType = UIKeyboardType.NumberPad
            self.GreenField = textField
        })
        newWordPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Red Chips"
            textField.keyboardType = UIKeyboardType.NumberPad
            self.RedField = textField
        })
        newWordPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "White Chips"
            textField.keyboardType = UIKeyboardType.NumberPad
            self.WhiteField = textField
        })
        newWordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: betEntered))
        presentViewController(newWordPrompt, animated: true, completion: nil)
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
        
        //place chips
        // self.view.addConstraint(NSLayoutConstraint(item: AllChipsView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        //)
        //self.view.layoutIfNeeded()
    }
    
    //Game Cards
    @IBOutlet var DealerCard1: UILabel!
    @IBOutlet var DealerCard2: UILabel!

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
        
        DealerCard2.text = String(dealer.HandCard[1].type!) + " " + String(dealer.HandCard[1].suit!)
        
        UserCard1.text = String(players[0].HandCard[0].type!) + " " + String(players[0].HandCard[0].suit!)
        UserCard2.text = String(players[0].HandCard[1].type!) + " " + String(players[0].HandCard[1].suit!)
        
        Player1Card1.text = String(players[1].HandCard[0].type!) + " " + String(players[1].HandCard[0].suit!)
        Player1Card2.text = String(players[1].HandCard[1].type!) + " " + String(players[1].HandCard[1].suit!)
        
        Player2Card1.text = String(players[2].HandCard[0].type!) + " " + String(players[2].HandCard[0].suit!)
        Player2Card2.text = String(players[2].HandCard[1].type!) + " " + String(players[2].HandCard[1].suit!)
        
        //Player4Card1.text = String(players[3].HandCard[0].type!) + " " + String(players[3].HandCard[0].suit!)
        //Player4Card2.text = String(players[3].HandCard[1].type!) + " " + String(players[3].HandCard[1].suit!)
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
        game.PlayersHands[0].stay()
    }
    
    @IBAction func OnHitAction(sender: UIButton) {
        print("hit")
        //game.PlayersHands[0].hit()
    }
    
    @IBAction func OnDoubleAction(sender: UIButton) {
        print("Double")
        game.PlayersHands[0].doubleDown()
    }
    
    @IBAction func OnSplitAction(sender: UIButton) {
        print("split")
        game.PlayersHands[0].split()
    }
    
    @IBAction func OnSurrAction(sender: UIButton) {
        print("Surrender")
        game.PlayersHands[0].surrender()
    }
    
    @IBAction func OnInsurAction(sender: UIButton) {
        print("Insurance")
    }
}
