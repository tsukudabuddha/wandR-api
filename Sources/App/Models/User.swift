//
//  User.swift
//  wandR-apiPackageDescription
//
//  Created by Andrew Tsukuda on 3/22/18.
//

import Vapor
import FluentProvider

final class User: Model {
    
    
    var storage = Storage()
    var username: String
    
    init(username: String) {
        self.username = username
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("username", username)
        return row
        
    }
    
    init(row: Row) throws {
        self.username = try row.get("username")
    }
}

// Fluent Prep

extension User: Preparation {
    static func prepare(_ database: Database) throws {
        
        // MARK: Define columns in database
        try database.create(self, closure: { (creator) in
            creator.id()
            creator.string("username")
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
    
    
}
