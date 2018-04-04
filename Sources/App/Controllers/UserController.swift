import Vapor
import Fluent

final class UserController {
    
    func index(_ req: Request) throws -> ResponseRepresentable {
        let list = try User.all()
        return try list.makeJSON()
    }
    
    func showUser(_ req: Request) throws -> ResponseRepresentable {
        guard let userId = req.parameters["id"]?.int else {
            return Response(status: .badRequest)
        }
        
        return try User.find(userId)!.makeJSON()
    }
    
    func create(_ req: Request) throws -> ResponseRepresentable {
        
        guard let username = req.data["username"]?.string else {
            return Response(status: .badRequest)
        }
        
        let user = User(username: username)
        try user.save()
        return Response(redirect: "/allUsers")
    }
    
    func remove(_ req: Request) throws -> ResponseRepresentable {
        guard let userId = req.data["id"]?.int else {
            return Response(status: .badRequest)
        }
        
        if let user = try User.find(userId) {
            try user.delete()
            return Response(status: .ok)
        }
        
        return Response(status: .imATeapot)
    }
}
