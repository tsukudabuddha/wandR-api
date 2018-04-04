//
//  Network.swift
//  wandR-apiPackageDescription
//
//  Created by Andrew Tsukuda on 3/22/18.
//

import Vapor
import Foundation

enum Route
{
    case post
    case comments(postId: Int)
    
    // Path
    func path() -> String {
        switch self {
        case .post:
            return "posts"
        case .comments:
            return "comments"
        }
    }
    
    // URL Parameters - query
    func urlParameters() -> [String : String]
    {
        let date = Date()
        switch self {
        case .post:
            let postParameters = ["search[featured]": "true",
                                  "scope": "public",
                                  "created_at": String(describing: date),
                                  "per_page": "20"]
            return postParameters
        case .comments(let postID):
            let commentsParameters = ["search[post_id]": String(describing: postID),
                                      "scope": "public",
                                      "created_at": String(describing: date),
                                      "per_page": "20"]
            return commentsParameters
        }
    }
    
    
    // Headers
    func headers() -> [String: String]
    {
        let urlHeaders =["Authorization": "Client-ID 0c0435fc2b2eaa7968f2b6f91c5cfb706363ac15b5acf50449a533339fdf31c2"]
        return urlHeaders
    }
    
    // Body
    // If http body is needed for Post request
    func body() -> Data?
    {
        switch self {
        case .post:
            return Data()
        default:
            return nil
        }
    }
}


class Network
{
    // Singleton
    static let shared = Network()
    
    let baseUrl = "https://api.unsplash.com/"
    let session = URLSession.shared
    
    // model: Decodable  - If you want parse the data into a decodable object
    func fetch(route: Route, completion: @escaping (Data) -> Void) {
        
        var fullUrlString = URL(string: baseUrl.appending(route.path()))
        fullUrlString = fullUrlString?.appendingQueryParameters(route.urlParameters())
        
        var getReuqest = URLRequest(url: fullUrlString!)
        getReuqest.allHTTPHeaderFields = route.headers()
        
        
        session.dataTask(with: getReuqest) { (data, response, error) in
            if let data = data {
                completion(data)
            }
            else
            {
                print(error?.localizedDescription ?? "Error")
            }
            }.resume()
    }
    
    func fetchPhotos(drop: Droplet) {
        let photo = try drop.client.get("https://api.unsplash.com/photos")
        print(photo)
    }
}
