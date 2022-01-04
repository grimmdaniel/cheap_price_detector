//
//  NetworkManager.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 18..
//

import Foundation

class NetworkManager {
    
    typealias Response = [String:Any]
    
    func performNetworkRequest(with httpObject: HTTPObject, completionHandler: @escaping (Result<Response, NetworkError>) -> Void) {
        
        guard let url = URL(string: httpObject.urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
            
        urlRequest.httpMethod = httpObject.type.rawValue
        urlRequest.allHTTPHeaderFields = httpObject.httpHeader
        
        if httpObject.type == .POST || httpObject.type == .PUT {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: httpObject.httpBody, options: [])
        }
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                completionHandler(.failure(.responseError));return
            }
            
            guard let responseData = data else {
                completionHandler(.failure(.responseError));return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                completionHandler(.failure(.NOStatusCode));return
            }
            
            if (200 ... 299) ~= statusCode {
                guard let responseJSON = (try? JSONSerialization.jsonObject(with: responseData)) as? [String:Any] else {
                    completionHandler(.failure(.JSONFormatError));return
                }
                completionHandler(.success(responseJSON))
            } else {
                if statusCode == 400 {
                    completionHandler(.failure(.badRequest));return
                } else if statusCode == 404 {
                    completionHandler(.failure(.notFound404));return
                } else {
                    completionHandler(.failure(.internalServerError));return
                }
            }
        }).resume()
    }
}
