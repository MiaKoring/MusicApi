//
//  SpotifyAuth.swift
//  MusicApi
//
//  Created by Mia Koring on 19.08.24.
//

struct SpotifyAuthResponse: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
}
