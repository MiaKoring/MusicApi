//
//  File.swift
//  
//
//  Created by Mia Koring on 19.08.24.
//

import Foundation
import Vapor

struct SpotifySongResponse: Codable {
    let album: SpotifyAlbum
    let artists: [SpotifyArtist]
    let disc_number: Int
    let duration_ms: Int
    let href: String
    let id: String
    let name: String
    let popularity: Int
    let preview_url: String?
    let track_number: Int
}
