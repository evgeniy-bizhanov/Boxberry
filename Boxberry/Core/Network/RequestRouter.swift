import Alamofire

enum RequestRouterEncoding {
    case url, json
}

protocol RequestRouter: URLRequestConvertible {
    
    var url: URL { get }
    var httpMethod: HTTPMethod { get }
    
    var method: String { get }
    var parameters: Parameters? { get }
    
    var encoding: RequestRouterEncoding { get }
}

extension RequestRouter {

    var encoding: RequestRouterEncoding {
        
        switch httpMethod {
        case .get:
            return .url
        default:
            return .json
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        switch self.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
