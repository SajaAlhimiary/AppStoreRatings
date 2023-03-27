import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    if let urlString = Environment.get("DATABASE_URL"),
       var postgresConfig = PostgresConfiguration(url: urlString){
        var tlsConfig = TLSConfiguration.makeClientConfiguration()
        tlsConfig.certificateVerification = .none
        postgresConfig.tlsConfiguration = tlsConfig
        
        app.databases.use(.postgres(configuration: postgresConfig), as:
                .psql)
    } else {
        app.databases.use (.postgres (
            hostname: Environment.get ("DATABASE_HOST") ?? "localhost",
            port:
                Environment.get("DATABASE_PORT").flatMap (Int.init(_:))
            ?? PostgresConfiguration.ianaPortNumber,
            username: Environment.get("DATABASE_USERNAME") ??
            "shahadmohammed",
            password: Environment.get("DATABASE_PASSWORD") ??
            "vapor",
            database: Environment.get("DATABASE_NAME") ??
            "appstoreratings" ) , as: .psql)
    }
    
    //Migration Config
    app.migrations.add(Createplatform())
    app.migrations.add(Creategames())
    
    try routes(app)

}

//, to: .psql
