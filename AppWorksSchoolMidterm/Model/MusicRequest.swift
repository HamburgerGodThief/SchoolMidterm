//
//  MusicRequest.swift
//  AppWorksSchoolMidterm
//
//  Created by Hamburger on 2020/1/17.
//  Copyright © 2020 Hamburger. All rights reserved.
//

import Foundation

struct PlayList {
    let token: String
    let offset: String
}

enum MusicRequest: STRequest {
    
    case playList(requireParameter: PlayList)
    
    case login
    
    var headers: [String : String]? {
        
        switch self{
            
        case .playList(let requireParameter): return [STHTTPHeaderField.auth.rawValue: "Bearer \(requireParameter.token)"]
            
        case .login: return [STHTTPHeaderField.contentType.rawValue: "application/x-www-form-urlencoded"]

        }
    }
    
    var body: Data? {
        
        switch self{
            
        case .playList: return nil
            
        case .login:
            
            let dict = [
                "grant_type": "client_credentials",
                "client_id": "77903f867f2f3a589c4066efe8627918",
                "client_secret": "f0f9218d37362a656b0000df371db257"
            ]
            
            var data = [String]()
            for(key, value) in dict {
                data.append(key + "=\(value)")
            }
            let string = data.map { String($0) }.joined(separator: "&")
            
            return string.data(using: String.Encoding.utf8)

        }
    }
    
    var method: String {
        
        switch self{
            
        case .playList: return STHTTPMethod.GET.rawValue
            
        case .login: return STHTTPMethod.POST.rawValue

        }
    }
    
    var endPoint: String {
        
        switch self{
            
        case .playList(let requireParameter): return "/v1.1/new-hits-playlists/DZrC8m29ciOFY2JAm3/tracks?limit=20&offset=\(requireParameter.offset)&territory=TW"
            
        case .login: return "/oauth2/token"

        }
    }
    
    
}
