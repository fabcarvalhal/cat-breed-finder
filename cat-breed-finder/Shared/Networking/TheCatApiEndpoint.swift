//
//  TheCatApiEndpoint.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import Foundation

enum TheCatApiEndpoint: Endpoint {
    
    case breeds
    
    var baseUrl: String {
        "https://api.thecatapi.com"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var path: String {
        "/v1/breeds"
    }
    
    var headers: [String : Any] {
        [HTTPHeaderField.xAPIKey.rawValue: "e7cd03bf-b0d4-4d53-9236-4ff96a5b2936"]
    }
}
