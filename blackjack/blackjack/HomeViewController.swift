//
//  HomeViewControlle.swift
//  blackjack
//
//  Created by Supinfo on 12/05/16.
//  Copyright © 2016 EtienneTR. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GotoGameViewController() {
        
        let IndexViewController = self.storyboard!.instantiateViewControllerWithIdentifier("IndexViewController");
        
        self.navigationController!.pushViewController(IndexViewController, animated: true);
    }
    
    @IBAction func PlayAction(sender: UIButton) {
        self.GotoGameViewController()
    }

}

