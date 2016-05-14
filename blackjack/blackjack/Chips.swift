//
//  Chips.swift
//  blackjack
//
//  Created by Supinfo on 14/05/16.
//  Copyright © 2016 EtienneTR. All rights reserved.
//

import Foundation

//JETONS

class Chips{
    var Blue : Int
    var Green : Int
    var Red : Int
    var White : Int
    var Black : Int
    
    init(nbBlue : Int, nbGreen : Int, nbRed : Int, nbWhite : Int, nbBlack : Int){
        self.Blue = nbBlue;
        self.Green = nbGreen;
        self.Red = nbRed;
        self.White = nbWhite;
        self.Black = nbBlack;
    }
    
    func double(){
        Blue = Blue*2
        Green = Green*2
        Red = Red*2
        White = White*2
        Black = Black*2
    }
    
    func halve(){
        let result = sumValue()/2
    }
    
    func sumValue() -> Int{
        return (Blue + Green + Red + White + Black)
    }
}