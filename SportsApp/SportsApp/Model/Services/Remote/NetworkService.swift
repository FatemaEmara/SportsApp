//
//  NetworkService.swift
//  SportsApp
//
//  Created by Fatema Emara on 08/05/2026.
//

import Foundation
import Alamofire

class NetworkService {
    static let shared = NetworkService()
    private init(){
        
    }
    func request<T: Decodable>(query: ApiQuery, completion: @escaping ((T?) -> Void)) {
       var parameters = query.parameters
       parameters["APIkey"] = APIConfig.apiKey
    
       AF.request(
           APIConfig.baseURL,
           method: .get,
           parameters: parameters
       )
       .validate()
       .responseDecodable(of: T.self) { response in
           switch response.result {
           case .success(let value):
               DispatchQueue.main.async {
                   completion(value)
               }
           case .failure(let error):
               print("Request failed: \(error)")
               DispatchQueue.main.async {
                   completion(nil)
               }
           }
       }
    }
   
}

