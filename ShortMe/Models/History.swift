//
//  History.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import Foundation

struct History: Identifiable, Codable, Equatable {
    
    enum CodingKeys: String, CodingKey {
        case orginalURL
        case shortURL
        case date
        case timeStamp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let orginalLink = try container.decode(Data.self, forKey: .orginalURL)
        let shortLink = try container.decode(Data.self, forKey: .shortURL)
        let dateTime = try container.decode(Data.self, forKey: .date)
        let time = try container.decode(Data.self, forKey: .timeStamp)
        
        orginalURL = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(orginalLink) as! String
        shortURL = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(shortLink) as! String
        date = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dateTime) as! String
        timeStamp = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(time) as! String
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let org = try NSKeyedArchiver.archivedData(withRootObject: orginalURL, requiringSecureCoding: false)
        try container.encode(org, forKey: .orginalURL)
        
        let short = try NSKeyedArchiver.archivedData(withRootObject: shortURL, requiringSecureCoding: false)
        try container.encode(short, forKey: .shortURL)
        
        let dateCreate = try NSKeyedArchiver.archivedData(withRootObject: date, requiringSecureCoding: false)
        try container.encode(dateCreate, forKey: .date)
        
        let timeCreate = try NSKeyedArchiver.archivedData(withRootObject: timeStamp, requiringSecureCoding: false)
        try container.encode(timeCreate, forKey: .timeStamp)
          
    }

    
    
    var id = UUID()
    
    var orginalURL: String = ""
    var shortURL: String = ""
    var date: String = ""
    var timeStamp: String = ""
    
    
    init(org: String, short: String) {
        orginalURL = org
        shortURL = short
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        date = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        timeStamp = dateFormatter.string(from: Date())
    }
    
}
