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
        self.Blue = self.Blue*2
        self.Green = self.Green*2
        self.Red = self.Red*2
        self.White = self.White*2
    }
    
    func halve(){
        var result: Int = sumValue()/2
        
        var wChanged = false
        var rChanged = false
        var gChanged = false
        var bChanged = false
        
        
        while result != 0{
        if(result >= 10){
        White = result / 10
        result = result % 10
        wChanged = true
        }
        else if(result >= 5){
        Red = result / 5
        result = result % 5
        rChanged = true
        }
        else if(result >= 2){
        Green = result / 2
        result = result % 2
        gChanged = true
        }
        else{
        Blue = result
        result = 0
        bChanged = true
        }
        }
        
        if wChanged == false { self.White = 0 }
        if rChanged == false { self.Red = 0 }
        if gChanged == false { self.Green = 0 }
        if bChanged == false { self.Blue = 0 }
 
    }
    
    func sumValue() -> Int{
        return (self.Blue*1 + self.Green*2 + self.Red*5 + self.White*10)
    }
}