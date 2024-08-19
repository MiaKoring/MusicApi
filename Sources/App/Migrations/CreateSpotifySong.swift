import Fluent

struct CreateSpotifySong: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("spotify-songs")
            .id()
            .field("spotify-id", .string, .required)
            .field("response", .string, .required)
            .field("last-updated", .int, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("spotify-songs").delete()
    }
}
