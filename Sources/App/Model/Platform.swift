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

final class Platform: Content , Model{
    static let schema = "platform"
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "Pname")
    var title: String
     
    @Children(for: \.$platform)
    var games: [Games]
    init() {}
    
    init(id: UUID? = nil, title: String){
        self.id = id
        self.title = title
    }
}

