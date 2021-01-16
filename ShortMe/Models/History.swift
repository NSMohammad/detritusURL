//
//  History.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import Foundation

struct History: Identifiable {
    var id = UUID()
    
    var orginalURL: String = ""
    var shortURL: String = ""
    
    var date: String = ""
    
    
    init(org: String, short: String) {
        orginalURL = org
        self.shortURL = short
        date = ""
    }
    
}
