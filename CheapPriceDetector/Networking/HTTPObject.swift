//
//  HTTPObject.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 18..
//

import Foundation

class HTTPObject {
    
    let type: HTTPMethod
    let urlString: String
    let httpHeader: [String:String]
    let httpBody: [String:Any]
    
    init(type: HTTPMethod, endpoint: Endpoints, httpHeader: [String:String], httpBody: [String:Any] = [:]) {
        self.type = type
        self.urlString = Endpoints.BASE_URL + endpoint.rawValue
        self.httpHeader = httpHeader
        self.httpBody = httpBody
    }
    
    init(type: HTTPMethod, endpoint: Endpoints, urlParameters: [String:String], httpHeader: [String:String], httpBody: [String:Any] = [:]) {
        self.type = type
        self.httpHeader = httpHeader
        self.httpBody = httpBody
        self.urlString = HTTPObject.addURLParams(url: Endpoints.BASE_URL + endpoint.rawValue,
                                      parameters: urlParameters)
        
    }
    
    private class func addURLParams(url: String, parameters: [String:String]) -> String {
        let url_with_params = url + "?"
        var tmp = [String]()
        for (k,v) in parameters {
            tmp.append(k+"="+v)
        }
        return url_with_params + tmp.joined(separator: "&")
    }
}
