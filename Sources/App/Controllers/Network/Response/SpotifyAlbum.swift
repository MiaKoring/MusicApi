//
//  File.swift
//  
//
//  Created by Mia Koring on 20.08.24.
//

import Foundation

struct SpotifyAlbum: Codable {
    let album_type: String
    let external_urls: [String: String]
    let total_tracks: Int
    let id: String
    let images: [SpotifyImage]
    let name: String
    let release_date: String
    let uri: String
    let artists: [SpotifyArtist]
}
