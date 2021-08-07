import Foundation

final class URLRequestBuilder {
    
    private(set) var baseUrl: String = ""
    private(set) var path: String = ""
    private(set) var method: HTTPMethod = .get
    private(set) var headers: [String: Any]?
    private(set) var parameters: RequestParams?
    private(set) var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    private(set) var timeoutInterval: Double = 60
    
    enum URLRequestBuilderError: LocalizedError {
        
        case invalidUrl
        
        var errorDescription: String? {
            switch self {
            case .invalidUrl:
                return "Invalid url"
            }
        }
    }
    
    init(with baseUrl: String) throws {
        guard let _ = URL(string: baseUrl) else {
            throw URLRequestBuilderError.invalidUrl
        }
        self.baseUrl = baseUrl
    }
    
    func set(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    func set(path: String) -> Self {
        self.path = path
        return self
    }
    
    func set(params: RequestParams) -> Self {
        self.parameters = params
        return self
    }
    
    func set(headers: [String: Any]?) -> Self {
        self.headers = headers
        return self
    }
    
    func set(cachePolicy: URLRequest.CachePolicy) -> Self {
        self.cachePolicy = cachePolicy
        return self
    }
    
    func set(timeoutInterval: Double) -> Self {
        self.timeoutInterval = timeoutInterval
        return self
    }
    
    func build() throws -> URLRequest {
        do {
            guard let url = URL(string: baseUrl) else {
                throw URLRequestBuilderError.invalidUrl
            }
            var urlRequest = URLRequest(url: url.appendingPathComponent(path),
                                        cachePolicy: cachePolicy,
                                        timeoutInterval: timeoutInterval
            )
            urlRequest.httpMethod = method.rawValue
                
            headers?.forEach {
                urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key)
            }
            
            if let params = parameters {
                urlRequest = try buildRequestParams(urlRequest, params: params)
            }
            
            return urlRequest
        } catch {
            throw URLRequestBuilderError.invalidUrl
        }
    }
    
    fileprivate func buildRequestParams(_ urlRequest: URLRequest, params: RequestParams) throws -> URLRequest {
        var urlRequest = urlRequest
        switch params {
            
        case .body(let params):
            urlRequest.httpBody = params
        case .query(let params):
            if let params = params {
                let queryParams = params.map { pair  in
                    return URLQueryItem(name: pair.key, value: "\(pair.value)")
                }
                var components = URLComponents(string: urlRequest.url!.absoluteString)
                components?.queryItems = queryParams
                urlRequest.url = components?.url
            }
        }
        
        return urlRequest
    }
    
}
