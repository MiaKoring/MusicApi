import Fluent
import Vapor

let globalState = GlobalState()

struct SpotifyController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let spotify = routes.grouped("spotify")
        
        spotify.get("track", ":id", use: song)
        // TODO: add playlist, album and artist support
    }
    
    @Sendable func song(req: Request) async throws -> SpotifySong {
        let id = try req.parameters.require("id")
        let song = try await SpotifySong.query(on: req.db)
            .filter(\.$spotifyID == id)
            .first()
        
        if let song, Int(Date().timeIntervalSinceReferenceDate) - song.lastUpdated > 3600 * 72 { //exists and is newer than 3 days
            return song
        } else if var song { //exists and is older than 3 days
            guard let token = await globalState.getSpotifyAuth(), await globalState.getSpotifyAuthExpires() < Int(Date.now.timeIntervalSinceReferenceDate) else { //if token is empty
                let res = try await updateAuth()
                
                let songRes = try await fetchSong(id: id, token: res.access_token, req: req)
                song.lastUpdated = Int(Date().timeIntervalSinceReferenceDate)
                song.response = songRes.response
                
                try? await song.update(on: req.db)
                
                return song
            }
        }
        
        guard let token = await globalState.getSpotifyAuth() else {
            let res = try await updateAuth()
            
            let songres = try await fetchSong(id: id, token: res.access_token, req: req)
            
            try? await songres.save(on: req.db)
            
            return songres
        }
        
        let songres = try await fetchSong(id: id, token: token.access_token, req: req)
        
        try? await songres.save(on: req.db)
        
        return songres
    }
    
    private func fetchSong(id: String, token: String, req: Request) async throws -> SpotifySong {
        let res = try await Network.request(SpotifySongResponse.self, environment: .spotify, endpoint: SpotifyAPI.track(id, token))
        
        guard let responseString = String(data: try JSONEncoder().encode(res), encoding: .utf8) else {
            throw Abort(.internalServerError, reason: "couldn't convert json data to string")
        }
        
        let spotifySong = SpotifySong(spotifyID: id, response: responseString, lastUpdated: Int(Date().timeIntervalSinceReferenceDate))
        
        return spotifySong
    }
    
    private func updateAuth() async throws -> SpotifyAuthResponse {
        guard let clientID = await globalState.getClientID(), let clientSecret = await globalState.getClientSecret() else {
            throw Abort(.internalServerError, reason: "clientID || clientSecret are not set")
        }
        
        let res = try await SpotifyAuth(clientID: clientID, clientSecret: clientSecret).request()
        await globalState.setSpotifyAuth(res)
        await globalState.setSpotifyAuthExpires(Int(Date.now.timeIntervalSinceReferenceDate) + res.expires_in - 5)
        
        return res
    }

}
