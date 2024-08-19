//
//  Untitled.swift
//  MusicApi
//
//  Created by Mia Koring on 19.08.24.
//

import Foundation

enum NetworkEnv {
    case spotify
}

extension NetworkEnv {
    var scheme: String {
        "https"
    }

    var host: String {
        switch self {
        case .spotify: "api.spotify.com"
        }
    }

    var path: String {
        switch self {
        case .spotify: "/v1"
        }
    }

    var components: URLComponents {
        var comp = URLComponents()
        comp.scheme = scheme
        comp.host = host
        comp.path = path
        return comp
    }
}
