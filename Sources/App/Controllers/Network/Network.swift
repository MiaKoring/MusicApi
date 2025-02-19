//
//  Network.swift
//  MusicApi
//
//  Created by Mia Koring on 19.08.24.
//

import Foundation
import Mammut

struct Network {
    
    static private var spotify: Mammut {
        Mammut(components: NetworkEnv.spotify.components, loglevel: .debug)
    }

    static func request<T: Codable>(
        _ T: T.Type,
        environment: NetworkEnv,
        endpoint: Endpoint
    ) async throws -> T {
        let result = await req(T.self, endpoint, environment )
        switch result {
        case .success(let success): return success
        case .failure(let failure): throw failure.self
        }
    }

    static private func req<T: Codable>(
        _ T: T.Type,
        _ endpoint: Endpoint,
        _ env: NetworkEnv
    ) async -> Result<T, Error> {
        switch env {
        case .spotify:
            return await spotify.request(endpoint, error: ErrorObj.self)
        }
    }
}

