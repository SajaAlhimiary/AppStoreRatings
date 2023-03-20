//
//  File.swift
//  
//
//  Created by Shahad Mohammed on 24/08/1444 AH.
//

import Foundation
import Vapor
import FluentPostgresDriver
import Fluent

struct Createplatform: Migration {
 
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("platform")
            .id()
            .field("Pname", .string)
            .create()
        
    }
    //undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("platform").delete()
    }
}


