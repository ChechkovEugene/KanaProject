//
//  Hieroglyph.swift
//  KanaProject
//
//  Created by Eugene Chechkov on 2/28/15.
//  Copyright (c) 2015 Eugene Chechkov. All rights reserved.
//

import Foundation

class Hieroglyph {
    let code: Int
    let name: String
    
    fileprivate convenience init() {
        self.init(code:-1, name:"noname")
    }
    
    init(code: Int,name: String){
        self.code = code
        self.name = name
    }
}
