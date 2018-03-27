import Vapor

extension Droplet {
    
    func setupRoutes() throws {
        
        let userController = UserController()
        
        get("allUsers", handler: userController.index)
        get("users", handler: userController.showUser)
        post("users", handler: userController.create)
        delete("users", handler: userController.remove)
        
        get("popular") { req in
            let photosResponse = try self.client.get("https://api.unsplash.com/photos", ["Authorization" : "Client-ID 0c0435fc2b2eaa7968f2b6f91c5cfb706363ac15b5acf50449a533339fdf31c2"
                ])
            let something = photosResponse.json!["urls"]!
            return something["regular"]!
        }
        
        get("search") { req in
            let photoResponse = try self.client.get("https://api.unsplash.com/search/photos?per_page=50&query=\(req.parameters["query"])", ["Authorization" : "Client-ID 0c0435fc2b2eaa7968f2b6f91c5cfb706363ac15b5acf50449a533339fdf31c2"
                ])
            let urls = photoResponse.json?["results"]?["urls"]?["regular"]
            return urls!
            
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
