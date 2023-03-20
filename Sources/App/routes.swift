import Vapor

func routes(_ app: Application) throws {
    
    //platform and games get
    app.get("platform") { req in
        Platform.query(on: req.db).all()
//            .with(\.$games).all()
        
    }

    
    //platform/id
    app.get("platform", ":platformId") { req -> EventLoopFuture<Platform> in
        Platform.find(req.parameters.get("platformId"), on: req.db)
            .unwrap(or: Abort(.notFound))
        
    }
    
    //games post = add
    app.post("platform") { req -> EventLoopFuture<Platform> in
        let platform = try req.content.decode(Platform.self)
        return platform.create(on: req.db).map {platform}
        
        
    }
    
    //Platform put = update

    app.put("platform"){ req -> EventLoopFuture<HTTPStatus> in
        let platform = try req.content.decode(Platform.self)
        return Platform.find(platform.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.title = platform.title
                return $0.update(on: req.db).transform(to: .ok)
            }
        
    }
        //Platform Delete
        app.delete("platform",":platformId"){ req -> EventLoopFuture<HTTPStatus> in
           Platform.find(req.parameters.get("platformId"), on: req.db)
                .unwrap(or: Abort(.notFound))
                .flatMap{
                    $0.delete(on: req.db)
                    
                }.transform(to: .ok)
            
        }
//
    //platform and games get
    app.get("games") { req in
        Games.query(on: req.db).with(\.$platform).all()

    }

//    //games/id
    app.get("games", ":gamesId") { req -> EventLoopFuture<Games> in
       Games.find(req.parameters.get("gamesId"), on: req.db)
            .unwrap(or: Abort(.notFound))

    }

    app.post("games") { req -> EventLoopFuture<Games> in
        let games = try req.content.decode(Games.self)
        return games.create(on: req.db).map {games}
    }

//
//
    app.put("games"){ req -> EventLoopFuture<HTTPStatus> in
        let games = try req.content.decode(Games.self)
        return Games.find(games.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.name = games.name
                $0.genre = games.genre
                $0.ageratings = games.ageratings
                $0.year = games.year
                $0.rating = games.rating
                return $0.update(on: req.db).transform(to: .ok)
            }

    }
        //Games Delete
        app.delete("games",":gamesId"){ req -> EventLoopFuture<HTTPStatus> in
          Games.find(req.parameters.get("gamesId"), on: req.db)
                .unwrap(or: Abort(.notFound))
                .flatMap{
                    $0.delete(on: req.db)

                }.transform(to: .ok)

        }
}
