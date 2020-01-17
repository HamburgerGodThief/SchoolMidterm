//
//  HTTPClient.swift
//  GCDPractice
//
//  Created by Hamburger on 2020/1/14.
//  Copyright © 2020 Hamburger. All rights reserved.
//

import Foundation

enum Result<T> {

    case success(T)

    case failure(Error)
}

enum STHTTPClientError: Error {

    case decodeDataFail

    case clientError(Data)

    case serverError

    case unexpectedError
}

enum STHTTPMethod: String {

    case GET

    case POST
    
}

enum STHTTPHeaderField: String {

    case contentType = "Content-Type"

    case auth = "Authorization"
}

enum STHTTPHeaderValue: String {

    case json = "application/json"
}

protocol STRequest {

    var headers: [String: String]? { get }

    var body: Data? { get }

    var method: String { get }

    var endPoint: String { get }
}

extension STRequest {
    
    func makeRequest() -> URLRequest {

        let urlString = "https://api.kkbox.com" + endPoint

        let url = URL(string: urlString)!

        var request = URLRequest(url: url)

        request.allHTTPHeaderFields = headers
        
        request.httpBody = body

        request.httpMethod = method

        return request
    }
    
    func login() -> URLRequest {

        let urlString = "https://account.kkbox.com" + endPoint

        let url = URL(string: urlString)!

        var request = URLRequest(url: url)

        request.allHTTPHeaderFields = headers
        
        request.httpBody = body

        request.httpMethod = method

        return request
    }
}

class HTTPClient {

    static let shared = HTTPClient()

    private let decoder = JSONDecoder()

    private let encoder = JSONEncoder()

    private init() { }

    func request(_ stRequest: STRequest, completion: @escaping (Result<Data>) -> Void) {

        URLSession.shared.dataTask(with: stRequest.makeRequest(), completionHandler: { (data, response, error) in

            guard error == nil else {

                return completion(Result.failure(error!))
            }
                
            // swiftlint:disable force_cast
            let httpResponse = response as! HTTPURLResponse
            // swiftlint:enable force_cast
            let statusCode = httpResponse.statusCode

            switch statusCode {

            case 200..<300:

                completion(Result.success(data!))

            case 400..<500:

                completion(Result.failure(STHTTPClientError.clientError(data!)))

            case 500..<600:

                completion(Result.failure(STHTTPClientError.serverError))

            default: return

                completion(Result.failure(STHTTPClientError.unexpectedError))
            }

        }).resume()
    }
    
    func login(_ stRequest: STRequest, completion: @escaping (Result<Data>) -> Void) {

        URLSession.shared.dataTask(with: stRequest.login(), completionHandler: { (data, response, error) in

            guard error == nil else {

                return completion(Result.failure(error!))
            }
                
            // swiftlint:disable force_cast
            let httpResponse = response as! HTTPURLResponse
            // swiftlint:enable force_cast
            let statusCode = httpResponse.statusCode

            switch statusCode {

            case 200..<300:

                completion(Result.success(data!))

            case 400..<500:

                completion(Result.failure(STHTTPClientError.clientError(data!)))

            case 500..<600:

                completion(Result.failure(STHTTPClientError.serverError))

            default: return

                completion(Result.failure(STHTTPClientError.unexpectedError))
            }

        }).resume()
    }
}
