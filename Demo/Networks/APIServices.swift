//
//  APIServices.swift
//  Demo
//
//  Created by Naina Ghormare on 4/20/20.
//  Copyright © 2020 Naina Ghormare. All rights reserved.
//

import Foundation
import UIKit

public enum HttpMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
}

extension String {
    var nsdata: Data {
        return self.data(using: String.Encoding.utf8, allowLossyConversion: false)!
    }
}

struct File {
    let name: String?
    let filename: String?
    let data: Data?
    init(name: String?,filename: String?, data: Data?) {
        self.name = name
        self.filename = filename
        self.data = data
    }
}

enum Result <T>{
    case Success(T)
    case Error(String)
}

public class APIService: NSObject {
    
    func startService(with method: HttpMethod, path: String, parameters: Dictionary<String,Any>?, target: BaseViewController, files: Array<File>?, completion: @escaping (Result<Any?>) -> Void) {
        guard let url = URL(string: Config.baseUrl+path) else { return completion(.Error("Invalid URL, we can't proceed.")) }
        print(url)
        let request = self.buildRequest(with: method, url: url, parameters: parameters, files: files)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return completion(.Error(error!.localizedDescription)) }
            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "Data not found."))
            }
            print(String(data: data, encoding: .utf8) ?? "")
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? Dictionary<String,AnyObject> {
                    print("Dataaaaaaa\(json)")
                    switch json["code"] as? Int {
                    case 200:
                        completion(.Success(json))
                   // case 401:
                       // AppDelegate().sharedInstance().logout()
                    default:
                        completion(.Error(json["message"] as? String ?? ""))
                    }
                }
            } catch let error {
                completion(.Error(error.localizedDescription))
            }
        }
        task.resume()
    }
    
}

extension APIService {
    
    func buildRequest(with method:HttpMethod,url:URL,parameters:Dictionary<String,Any>?,files:Array<File>?) -> URLRequest {
        
        var request:URLRequest? = nil
        
        switch method {
            
        case .GET:
            
            if let params = parameters,params.count > 0 {
                let queryUrl = url.appendingPathComponent("?"+buildParams(parameters: params))
                request = URLRequest(url: queryUrl)
            } else {
                request = URLRequest(url: url)
            }
            request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
        case .POST,.PUT:
            
            request = URLRequest(url: url)
            
            if let images = files,images.count > 0 {
                
                let boundary = "Boundary-\(UUID().uuidString)"
                let boundaryPrefix = "--\(boundary)\r\n"
                let boundarySuffix = "--\(boundary)--\r\n"
                
                request?.addValue("multipart/form-data; boundary=" + boundary, forHTTPHeaderField: "Content-Type")
                let data = NSMutableData()
                if let params = parameters,params.count > 0{
                    for (key, value) in params {
                        data.append("--\(boundary)\r\n".nsdata)
                        data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".nsdata)
                        data.append("\((value as AnyObject).description ?? "")\r\n".nsdata)
                    }
                }
                for file in images {
                    data.append(boundaryPrefix.nsdata)
                    data.append("Content-Disposition: form-data; name=\"\(file.name!)\"; filename=\"\(NSString(string: file.filename!))\"\r\n\r\n".nsdata)
                    if let a = file.data {
                        data.append(a)
                        data.append("\r\n".nsdata)
                    } else {
                        print("Could not read file data")
                    }
                }
                data.append(boundarySuffix.nsdata)
                request?.httpBody = data as Data
            } else if let params = parameters,params.count > 0 {
                request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
                let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request?.httpBody = jsonData
            }
        default:
            // write code for delete here
            break
        }
        
        
        // pass your authorisation token here.
        // it can be saved in nsuserdefaaults of in singelton
       // if let dict = AppInstance.shared.kUserDefault.object(forKey: Macros.userDetails) as? Dictionary<String,Any> {
         //   let user = User(dictionary: dict)
           // let token = user?.token
            //print(token ?? "")
                //token.replacingOccurrences(of: " ", with: "%20") //.replacingOccurrences(of: " ", with: "%20")
            request?.addValue( "", forHTTPHeaderField: "Authorization")//Authorization
            
       // }//UserDefaults.standard.object(forKey: "user") as? Dictionary<String,Any>
        
        request?.httpMethod = method.rawValue
        
        return request ?? URLRequest(url: url)
    }
    
    func buildParams(parameters: Dictionary<String,Any>) -> String {
        var components: [(String, String)] = []
        for (key,value) in parameters {
            components += self.queryComponents(key, value)
        }
        return (components.map{"\($0)=\($1)"} as [String]).joined(separator: "&")
    }
    func queryComponents(_ key: String, _ value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? Dictionary<String,Any> {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.append(contentsOf: [(escape(string: key), escape(string: "\(value)"))])
        }
        
        return components
    }
    func escape(string: String) -> String {
        if let encodedString = string.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) {
            return encodedString
        }
        return ""
    }
}
