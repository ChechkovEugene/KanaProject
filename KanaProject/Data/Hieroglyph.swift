//
//  Hieroglyph.swift
//  KanaProject
//
//  Created by Eugene Chechkov on 2/28/15.
//  Copyright (c) 2015 Aejis. All rights reserved.
//

import Foundation

class Hieroglyph: NSObject {
    let code: Int
    let name: String
    
    private override convenience init() {
        self.init(code:-1, name:"noname")
    }
    
    init(code: Int,name: String){
        self.code = code
        self.name = name
    }
}
