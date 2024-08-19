//
//  SpotifyApi.swift
//  MusicApi
//
//  Created by Mia Koring on 19.08.24.
//

import Foundation
import Mammut

enum SpotifyAPI {
    case track(String, String)
}

extension SpotifyAPI: Endpoint {

    var path: String {
        switch self {
        case .track(let id, _): "/tracks/\(id)"
        }
    }

    var method: MammutMethod {
        switch self {
        case .track: .get
        }
    }

    var headers: [MammutHeader] {
        switch self {
        case .track(_, let token): [.authorization(.bearer("\(token)"))]
        }
    }

    var parameters: [String : Any] {
        [:]
    }

    var encoding: Encoding {
        .json
    }
}
