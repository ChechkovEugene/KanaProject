//
//  KanaService.swift
//  KanaProject
//
//  Created by Eugene Chechkov on 2/20/15.
//  Copyright (c) 2015 Eugene Chechkov. All rights reserved.
//

import Foundation

enum KanaType {
    case hiragana, katakana
}

class KanaService: NSObject {
    
    class func generateRandoms(_ count:Int, upperBound:Int) -> [Int] {
        
        var shuffle:[Int] = []
        
        while (shuffle.count < count) {
            let num = KanaService.generateRandomNumberWithUpperBound(upperBound)
    
            if (!shuffle.contains(num)) {
               shuffle.append(num)
            }
        }
    
        return shuffle;
    }
    
    class func generateRandomNumberWithUpperBound(_ bound:Int) -> Int {
       
        let low_bound = 0;
        let high_bound = bound;
        let width = high_bound - low_bound;
        let randomNumber = low_bound + Int(arc4random_uniform(UInt32(width)));
    
        return randomNumber;
    }
    
    class func loadHierosFromFile(_ type: KanaType) ->[Hieroglyph]? {
        
        let resName = type == .hiragana ? "Hiragana": "Katakana"
        
        if let path = Bundle.main.path(forResource: resName, ofType: "plist") {
            if let hierosList = NSArray(contentsOfFile: path) as? [[String:AnyObject]] {
                var hieros:[Hieroglyph] = []
                for hieroElement in hierosList {
                    let hiero = Hieroglyph(code: hieroElement["Code"] as! Int, name: hieroElement["Name"] as! String)
                    hieros.append(hiero)
                }
                return hieros
            }
        }
        return nil
    }
}
	
