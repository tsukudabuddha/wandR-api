import Vapor

extension Droplet {
    
    func setupRoutes() throws {
        
        let userController = UserController()
        
        get("allUsers", handler: userController.index)
        get("users", handler: userController.showUser)
        post("users", handler: userController.create)
        delete("users", handler: userController.remove)
        
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
    }
}
