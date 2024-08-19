//
//  File.swift
//  
//
//  Created by Mia Koring on 19.08.24.
//

import Foundation
import Vapor

actor GlobalState {
    private var _spotifyAuth: SpotifyAuthResponse? = nil
    private var _expires: Int = 0
    private var _clientID: String? = nil
    private var _clientSecret: String? = nil
    
    func getSpotifyAuth() -> SpotifyAuthResponse? {
        return _spotifyAuth
    }

    func setSpotifyAuth(_ newValue: SpotifyAuthResponse?) {
        _spotifyAuth = newValue
    }
    
    func getSpotifyAuthExpires() -> Int {
        return _expires
    }

    func setSpotifyAuthExpires(_ newValue: Int) {
        _expires = newValue
    }
    
    func getClientID() -> String? {
        return _clientID
    }

    func setClientID(_ newValue: String?) {
        _clientID = newValue
    }
    
    func getClientSecret() -> String? {
        return _clientSecret
    }

    func setClientSecret(_ newValue: String?) {
        _clientSecret = newValue
    }
}

