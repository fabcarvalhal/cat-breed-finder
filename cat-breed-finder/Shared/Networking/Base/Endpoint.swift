import Foundation

protocol Endpoint {
    
    var baseUrl: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: Any] { get }
}

