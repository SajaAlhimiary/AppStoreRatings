//
//  File.swift
//  
//
//  Created by Shahad Mohammed on 26/08/1444 AH.
//

import Foundation
import Vapor

final class PlatformController {

func create(_ req: Request) throws -> EventLoopFuture<Platform> {
    let platform = try req.content.decode(Platform.self)
    return platform.create(on: req.db).map { platform }
}

func all(_ req: Request) throws -> EventLoopFuture<[Platform]> {
   Platform.query(on: req.db).all()
}

func getid(req:Request) throws -> EventLoopFuture<Platform> {
    Platform.find(req.parameters.get("platformId"), on: req.db)
    .unwrap(or: Abort(.notFound))
}

func updata(req:Request) throws -> EventLoopFuture<HTTPStatus> {
    
            let platform = try req.content.decode(Platform.self)
    
            return Platform.find(platform.id, on: req.db)
                .unwrap(or: Abort(.notFound))
                .flatMap {
                    $0.title = platform.title
                    return $0.update(on: req.db).transform(to: .ok)
                }
}


func delete(req:Request) throws -> EventLoopFuture<HTTPStatus> {
    Platform.find(req.parameters.get("platformId"), on: req.db).unwrap(or: Abort(.notFound))
                .flatMap {
                    $0.delete(on: req.db)
                }.transform(to: .ok)
}
}
