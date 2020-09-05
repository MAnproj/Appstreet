//
//  Hits.swift
//  Appstreet
//
//  Created by abc on 28/08/20.
//  Copyright © 2020 abc. All rights reserved.
//

import Foundation

struct Facts: Codable {
    var total: Int = 0
    var totalHits: Int = 0
    var hits: [Hit]
    
    enum CodingKeys: String, CodingKey{
        case total 
        case totalHits
        case hits
    }
}
struct Hit:Codable {
    var previewURL: String?
    var tags: String?
    
    enum CodingKeys: String, CodingKey{
        case previewURL
        case tags
    }    
}


