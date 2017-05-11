//
//  Router.swift
//  themoviedb
//
//  Created by Yasser Mabrouk on 5/6/17.
//  Copyright © 2017 Yasser Mabrouk. All rights reserved.
//

import Foundation

import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "https://api.themoviedb.org/3/movie"
    static let API_KEY = "eaec4bfed9794e1861e198547d9d9073";
    
    case login(parameters: Parameters)
    case createUser(parameters: Parameters)
    case getPopular()
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .createUser:
            return .post
        case .getPopular:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/v2/account/login"
        case .createUser:
            return "/v2/account/create"
        case .getPopular:
            return "/popular"
        }
    }

    // MARK: URLRequestConvertible
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .login(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .createUser(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .getPopular():
            let parameters: Parameters = [
                "api_key" : Router.API_KEY,
            ]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}

