//
//  File.swift
//  
//
//  Created by Shahad Mohammed on 27/08/1444 AH.
//

import Foundation
import Fluent
import FluentPostgresDriver
import Vapor


final class Games: Model, Content{
    static let schema = "games"

    @ID(key: .id)
    var id: UUID? // PK
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "genre(s)")
    var genre: String
    
    @Field(key: "age ratings")
    var ageratings: String
    
    @Field(key: "year")
    var year: Int
    
    @Field(key: "rating")
    var rating: Double
    
    //Games hammens in a platform
    @Parent(key: "platform_id") //FK
    var platform: Platform
    init() {}
    
    init(id: UUID? = nil, name:String, genre: String, ageratings:String, year: Int, rating: Double, platformId: UUID) {
        self.id = id
        self.name = name
        self.genre = genre
        self.ageratings = ageratings
        self.year = year
        self.rating = rating
        self.$platform.id = platformId
    }
}
