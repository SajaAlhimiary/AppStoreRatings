//
//  File.swift
//  
//
//  Created by Shahad Mohammed on 27/08/1444 AH.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

struct Creategames: Migration{
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("games")
            .id()
            .field("name", .string)
            .field("genre(s)", .string)
            .field("age ratings", .string)
            .field("year", .int)
            .field("rating", .double)
            .field("platform_id", .uuid, .references("platform", "id"))
            .create()
        
        
        
        
            
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("games").delete()
    }
}


//@Field(key: "name")
//var name: String
//
//@Field(key: "genre(s)")
//var genre: String
//
//@Field(key: "age ratings")
//var ageratings: String
//
//@Field(key: "year")
//var year: Int
//
//@Field(key: "rating")
//var rating: Int
//
////Games hammens in a platform
//@Parent(key: "platform_id") //FK
//var platform: Platform
//init() {}
