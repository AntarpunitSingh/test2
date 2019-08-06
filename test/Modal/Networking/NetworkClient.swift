//
//  NetworkClient.swift
//  testing
//
//  Created by Antarpunit Singh on 2012-08-05.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import Foundation

class NetworkClient {
    struct Auth {
        
        static let id = "https://api.giphy.com/v1/gifs/trending?api_key=jnLveXZIKRLJ0jdEAzQiqjtbmALbBei4&limit=20&rating=G"
        
    }
    enum Endpoints {
        static let base = "https://api.giphy.com/v1"
        static let apiKey = "SB6ZuykXWDKyJKWDY3QNz5GYoVB6XNe6"
        static let apiKey2 = "jnLveXZIKRLJ0jdEAzQiqjtbmALbBei4"
        
        case trending(String)
        
        var stringValue:String {
            switch self {
            case .trending(let limit):
                return Endpoints.base + "/gifs/trending" + "?api_key=\(Endpoints.apiKey)" + "&limit=\(limit)" + "&rating=G"
            }
        }
        var url:URL {
            return (URL(string: stringValue)!)
        }
    }
    
    class func taskGetRequest<responseType:Decodable>(url : URL,responseType: responseType.Type, completion: @escaping(responseType? ,Error?)->Void){
        let taskForGet = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
                return
            }
            do {
                let decode = try JSONDecoder().decode(responseType.self, from: data)
                DispatchQueue.main.async {
                    completion(decode , nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }
        }
        taskForGet.resume()
    }
    class func getTrendingGif(completion:@escaping([DataObject]?,Error?)->Void) {
        taskGetRequest(url: Endpoints.trending("15").url, responseType: GifResponse.self) { (response, error) in
            if let response = response {
                
                completion(response.data,nil)
                print(response.meta.status)
                print(response.meta.msg)
            }
            else {
                completion([],error)
                print(error?.localizedDescription ?? "")
                
                
            }
        }
        

    }
}
