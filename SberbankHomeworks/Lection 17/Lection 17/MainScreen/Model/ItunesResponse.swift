//
//  ItunesResponse.swift
//  Lection 17
//
//  Created by Kirill Magerya on 01.06.2021.
//

import Foundation

struct ItunesResponse: Codable {
    
    var results: [Track]
}

struct Track: Codable {
    
    var trackName: String?
    var artworkUrl100: String
}
