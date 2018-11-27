import Alamofire

/**
 Предоставляет реализацию сетевого запроса по умолчанию
 */
protocol AbstractRequestManager {
    associatedtype TData: Decodable
    typealias Completion = (DataResponse<TData>) -> Void
    
    var errorParser: ​AbstractErrorParser​ { get }
    var sessionManager: SessionManager { get }
    var queue: DispatchQueue? { get }
    
    @discardableResult
    func request(
        request: URLRequestConvertible,
        completion: @escaping Completion) -> DataRequest
    
    init (
        errorParser: ​AbstractErrorParser​,
        sessionManager: SessionManager,
        queue: DispatchQueue?
    )
}

extension AbstractRequestManager {
    
    @discardableResult public func request(
        request: URLRequestConvertible,
        completion: @escaping Completion) -> DataRequest {
        
        return sessionManager
            .request(request)
            .responseCodable(
                errorParser: errorParser,
                queue: queue,
                completion: completion
        )
    }
}
