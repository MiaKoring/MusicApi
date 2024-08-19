//
//  File.swift
//  
//
//  Created by Mia Koring on 20.08.24.
//

import Foundation

struct SpotifyArtist: Codable {
    let id: String
    let name: String
    let uri: String
    let external_urls: [String: String]
}
