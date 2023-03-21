//
//  File.swift
//  
//
//  Created by Shahad Mohammed on 29/08/1444 AH.
//

import Foundation
import Vapor

struct GamesController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        let games = routes.grouped("games")
        games.get(use: all)
       games.post(use: create)

        games.group(":gamesId") { games in
           games.put(use: update)
           games.delete(use: delete)
        }
    }

func create(_ req: Request) throws -> EventLoopFuture<Games> {
       let games = try req.content.decode(Games.self)
       return games.create(on: req.db).map { games }
   }

   func all(_ req: Request) throws -> EventLoopFuture<[Games]> {
       Games.query(on: req.db).all()
   }


func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {

              let games = try req.content.decode(Games.self)

              return Games.find(games.id, on: req.db)
                  .unwrap(or: Abort(.notFound))
                  .flatMap {
                      $0.name = games.name
                      $0.genre = games.genre
                      $0.ageratings = games.ageratings
                      $0.year = games.year
                      $0.rating = games.rating
                      
                      return $0.update(on: req.db).transform(to: .ok)
                  }
  }


func delete(req:Request) throws -> EventLoopFuture<HTTPStatus> {
    Games.find(req.parameters.get("gamesId"), on: req.db).unwrap(or: Abort(.notFound))
                .flatMap {
                    $0.delete(on: req.db)
                }.transform(to: .ok)
}
}
