import Vapor

final class UserController {
    
    func list(_ req: Request) throws -> ResponseRepresentable {
        let list = try User.all()
        return try list.makeJSON()
    }
    
    func singleUser(_ req: Request) throws -> ResponseRepresentable {
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
        return Response(redirect: "/users")
    }
}
