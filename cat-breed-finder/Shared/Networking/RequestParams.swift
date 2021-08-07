import Foundation

enum RequestParams {
    
    typealias QueryParameters = [String: Any]
    
    case body(Data?)
    case query(QueryParameters?)
}
