import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("spotify") { req async throws -> String in
        let res = try await SpotifyAuth(clientID: "b04c34f5c4024152837c79e3e4305df3", clientSecret: "68b5b5fbdb1944c0b22abaf4fb872cb0").request()
        return res.access_token
    }

    try app.register(collection: SpotifyController())
}
