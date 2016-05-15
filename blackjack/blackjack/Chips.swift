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
    
    init(nbBlue : Int, nbGreen : Int, nbRed : Int, nbWhite : Int){
        self.Blue = nbBlue;
        self.Green = nbGreen;
        self.Red = nbRed;
        self.White = nbWhite;
    }
    
    func double(){
        Blue = Blue*2
        Green = Green*2
        Red = Red*2
        White = White*2
    }
    
    func halve(){
        var result: Int = sumValue()/2
        if(result > 10){
        White = result / 10
        result = result % 10
        }
        else if(result > 5){
        Red = result / 5
        result = result % 5
        }
        else if(result > 2){
        Green = result / 2
        result = result % 2
        }
        else{
        Blue = result
        }
    }
    
    func sumValue() -> Int{
        return (Blue*1 + Green*2 + Red*5 + White*10)
    }
}