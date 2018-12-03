import Alamofire

enum RequestRouterEncoding {
    case url, json
}

protocol RequestRouter: URLRequestConvertible {
    
    var url: URL { get }
    var httpMethod: HTTPMethod { get }
    var encoding: RequestRouterEncoding { get }
    var method: String { get }
    
    var parameters: Parameters? { get }
}

protocol RequestParameter {
    
    func parameters() -> Parameters?
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
        
        let parameters = (self as? RequestParameter)?.parameters() ?? self.parameters
        
        switch self.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
