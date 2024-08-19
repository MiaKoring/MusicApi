//
//  SpotifyAuth.swift
//  MusicApi
//
//  Created by Mia Koring on 19.08.24.
//
import Foundation
import Vapor

struct SpotifyAuth {
    let clientID: String
    let clientSecret: String
    static let url = URL(string: "https://accounts.spotify.com/api/token")
    var error: Error? = nil
    
    func request() async throws -> SpotifyAuthResponse {
        guard let url = SpotifyAuth.url else {
            throw Abort(.internalServerError, reason: "Set spotifyAuthURL is invalid")
        }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue(authValue, forHTTPHeaderField: "Authorization")
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let bodyData = "grant_type=client_credentials"
        req.httpBody = bodyData.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: req)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw Abort(.internalServerError, reason: "couldn't authenticate with spotify API")
        }
        
        
        let auth = try JSONDecoder().decode(SpotifyAuthResponse.self, from: data)
        
        return auth
    }
}

extension SpotifyAuth {
    var authValue: String? {
        guard let data = "\(self.clientID):\(self.clientSecret)".data(using: .utf8) else { return nil }
        return "Basic \(data.base64EncodedString())"
    }
}
