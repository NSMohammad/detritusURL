//
//  ApiRequests.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIRequest {
    
    static let sharedInstance = APIRequest()
    
    func getCuttLy(url: String, completion: @escaping (History?) -> Void) {
        get(URL: "https://cutt.ly/api/api.php?key=fe0a750603e3c1043dbd659567026e7756ed0&short=\(url)", completion: { response in
            if response != nil {
                let json = response!.data(using: String.Encoding.utf8).flatMap({try? JSON(data: $0)}) ?? JSON(NSNull())
                let shortLink = json["url"]["shortLink"].stringValue
                
                completion(History(org: url, short: shortLink))
            }else {
                completion(nil)
            }
        })
    }
    func getVGd(url: String, completion: @escaping (History?) -> Void) {
        get(URL: "https://v.gd/create.php?format=simple&url=\(url)", completion: { response in
            if response == nil {
                completion(nil)
            }else {
                completion(History(org: url, short: response!))
            }
        })
    }
    func getIsGd(url: String, completion: @escaping (History?) -> Void) {
        get(URL: "https://is.gd/create.php?format=simple&url=\(url)", completion: { response in
            if response == nil {
                completion(nil)
            }else {
                completion(History(org: url, short: response!))
            }
        })
    }
    func getMurlCom(url: String, completion: @escaping (History?) -> Void) {
        
        var sendURL = url
        
        if sendURL.uppercased().contains("HTTPS") {
            sendURL.removeFirst(8)
        }else if sendURL.uppercased().contains("HTTP") {
            sendURL.removeFirst(7)
        }
        get(URL: "https://murl.com/api.php?url=\(sendURL)", completion: { response in
            guard let respons = response else { return }
            completion(History(org: url, short: respons))
        })
    }
    func getShrtcoDe(url: String, completion: @escaping (History?) -> Void) {
        get(URL: "https://api.shrtco.de/v2/shorten?url=\(url)", completion: { response in
            print(response ?? "nil")
            if response != nil {
                let json = response!.data(using: String.Encoding.utf8).flatMap({try? JSON(data: $0)}) ?? JSON(NSNull())
                let shortLink = json["result"]["full_short_link"].stringValue
                completion(History(org: url, short: shortLink))
            }else {
                completion(nil)
            }
        })
    }
    
    
    func postTinyUrl(url: String, completion: @escaping (History?) -> Void) {
        post(URL: "http://tiny-url.info/api/v1/random",params: ["apikey": "7BC5AG80B796CD9DB5A3", "format": "json", "url": url], completion: { response in
            if response != nil {
                let json = JSON(response!)
                let shortLink = json["shorturl"].stringValue
                completion(History(org: url, short: shortLink))
            }else {
                completion(nil)
            }
        })
    }
    
    func postHideuri(url: String, completion: @escaping (History?) -> Void) {
        post(URL: "https://hideuri.com/api/v1/shorten",params: ["url": url], completion: { response in
            if response != nil {
                let json = JSON(response!)
                let shortLink = json["result_url"].stringValue
                completion(History(org: url, short: shortLink))
            }else {
                completion(nil)
            }
        })
    }
    
    func postShrturi(url: String, completion: @escaping (History?) -> Void) {
        post(URL: "https://shrturi.com/api/v1/shorten",params: ["url": url], completion: { response in
            if response != nil {
                let json = JSON(response!)
                let shortLink = json["result_url"].stringValue
                completion(History(org: url, short: shortLink))
            }else {
                completion(nil)
            }
        })
    }
    
    private func get(URL: String = "",params:Parameters? = nil ,headers: HTTPHeaders? = nil , completion: @escaping (String?) -> Void) {
        AF.request(URL,method: .get, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseString { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure:
                completion(nil)
            }
        }
    }
    
    private func post(URL: String = "",params:Parameters? = nil ,headers: HTTPHeaders? = nil , completion: @escaping (JSON?) -> Void) {
        AF.request(URL,method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure:
                completion(nil)
            }
        }
    }
}
