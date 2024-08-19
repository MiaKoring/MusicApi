import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("MUSIC_DATABASE_HOST") ?? "localhost",
        port: Environment.get("MUSIC_DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("MUSIC_DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("MUSIC_DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("MUSIC_DATABASE_NAME") ?? "vapor_database",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)
    
    await globalState.setClientID(Environment.get("SPOTIFY_CLIENT_ID"))
    await globalState.setClientSecret(Environment.get("SPOTIFY_CLIENT_SECRET"))

    //migratons
    app.migrations.add(CreateSpotifySong())
    // register routes
    try routes(app)
}
