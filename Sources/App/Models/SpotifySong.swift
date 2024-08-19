import Fluent
import Vapor
import struct Foundation.UUID

/// Property wrappers interact poorly with `Sendable` checking, causing a warning for the `@ID` property
/// It is recommended you write your model with sendability checking on and then suppress the warning
/// afterwards with `@unchecked Sendable`.
final class SpotifySong: Model, @unchecked Sendable {
    static let schema = "spotify-songs"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "spotify-id")
    var spotifyID: String
    
    @Field(key: "response")
    var response: String
    
    @Field(key: "last-updated")
    var lastUpdated: Int
    
    init() { }

    init(id: UUID? = nil, spotifyID: String, response: String, lastUpdated: Int) {
        self.id = id
        self.spotifyID = spotifyID
        self.response = response
        self.lastUpdated = lastUpdated
    }
}

extension SpotifySong: AsyncResponseEncodable {
    func encodeResponse(for request: Vapor.Request) async throws -> Vapor.Response {
        let data = try JSONEncoder().encode(self)
        return Response(status: .ok, body: .init(data: data))
    }
}
