import Alamofire

/**
 Предоставляет реализацию сетевого запроса по умолчанию
 */
protocol AbstractRequestManager {
    
    typealias Completion<T: Decodable> = (DataResponse<T>) -> Void
    
    var errorParser: AbstractErrorParser { get }
    var sessionManager: SessionManager { get }
    var queue: DispatchQueue? { get }
    
    @discardableResult
    func request<T>(
        request: URLRequestConvertible,
        completion: @escaping Completion<T>) -> DataRequest
    
    init (
        errorParser: AbstractErrorParser,
        sessionManager: SessionManager,
        queue: DispatchQueue?
    )
}

extension AbstractRequestManager {
    
    @discardableResult public func request<T>(
        request: URLRequestConvertible,
        completion: @escaping Completion<T>) -> DataRequest {
        
        return sessionManager
            .request(request)
            .responseCodable(
                errorParser: errorParser,
                queue: queue,
                completion: completion
        )
    }
}
