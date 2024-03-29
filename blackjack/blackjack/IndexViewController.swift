//
//  IndexViewController.swift
//  blackjack
//
//  Created by Supinfo on 13/05/16.
//  Copyright © 2016 EtienneTR. All rights reserved.
//

import UIKit
import Foundation

class IndexViewController: UIViewController {
    
    var IndexBlue = 0
    
    @IBOutlet var IndexField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Début de la partie"
        
        //InputIndex.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Placement de la carte bleu en interface
    func ShowBlueCardAsk(Index : String){
        //call game board
        //redirect game viewer
        IndexBlue = Int(Index)!
        GotoGameViewController()
    }
    
    //NAVIGATE : Game Controller
    func GotoGameViewController() {
        
        let gameViewController = self.storyboard!.instantiateViewControllerWithIdentifier("GameViewController") as! GameViewController;
        gameViewController.IndexBlueCard = IndexBlue
        self.navigationController!.pushViewController(gameViewController, animated: true);
    }
    
    //ACTIONS : FIELD AND BUTTON (validate)
    
    /*@IBAction func DidEndOnExit(sender: UITextField) {
        let index = sender.text;
        if(!index!.isEmpty){
            self.ShowBlueCardAsk(index!);
        }
    }*/
    @IBAction func IndexOkAction(sender: UIButton) {
        let index = IndexField.text;
        if(!index!.isEmpty){
            self.ShowBlueCardAsk(index!);
        }
    }
}