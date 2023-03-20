//
//  File.swift
//  
//
//  Created by Shahad Mohammed on 26/08/1444 AH.
//

//import Fluent
//import Vapor
//
//struct GamesContrroller: RouteCollection{
//    func boot(routes:RoutesBuilder) throws {
//        let platform = routes.grouped("platform")
//        platform.get (use: index)
//    }
//    func index(req: Request) throws -> EventLoopFuture<[platform]> {
//        return platform.query(on: req.db).all()
//    }
//   
//}


//func boot(routes: RoutesBuilder) throws {
//    let platform = routes.grouped("platform")
//    platform.get (use: index)
//    platform.post (use: creat)
//
//}
//func index(req: Request) throws -> EventLoopFuture<[platform]> {
//    let platform = try req.content.decode(platform.self)
//    return platform.save(on: req.db).transform(to: ok)
//}
