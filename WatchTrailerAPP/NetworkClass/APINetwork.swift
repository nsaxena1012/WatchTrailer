//
//  APINetwork.swift
//  WatchTrailerAPP
//
//  Created by apple on 04/12/24.
//

import Foundation
import Alamofire

class APINetwork {
    // Singleton Pattern for passing one instance
    static let shared = APINetwork()
    
    private init() {}
    /*
     The closure in the function signature you provided is just a regular closure parameter.
    */
    func fetchMovies(endPoint:String , completion: @escaping (Result<Data,Error>) ->Void) {
        let url = "\(BaseUrl.baseURL)\(endPoint)" // baseUrl+endpoint defined
        let parameter : [String:Any] = ["api_key":"\(BaseUrl.apiKey)"] // api_key take as a parameter using dictonary
        
        
        // Almofire network request created and its a trailing closure
        AF.request(url, parameters: parameter).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
