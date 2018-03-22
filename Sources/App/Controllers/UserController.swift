import Vapor

final class UserController {
    
    func list(_ req: Request) throws -> ResponseRepresentable {
        let list = try User.all()
        return try list.makeJSON()
    }
    
}
