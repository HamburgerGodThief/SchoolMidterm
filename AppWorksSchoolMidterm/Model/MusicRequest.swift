//
//  MusicRequest.swift
//  AppWorksSchoolMidterm
//
//  Created by Hamburger on 2020/1/17.
//  Copyright © 2020 Hamburger. All rights reserved.
//

import Foundation

enum MusicRequest: STRequest {
    
    case playList
    
    var headers: [String : String]? {
        
        switch self{
            
        case .playList: return [STHTTPHeaderField.auth.rawValue: "Bearer AuGyYS7TDMqec8Sux6KoAw=="]

        }
    }
    
    var body: Data? {
        
        switch self{
            
        case .playList: return nil

        }
    }
    
    var method: String {
        
        switch self{
            
        case .playList: return STHTTPMethod.GET.rawValue

        }
    }
    
    var endPoint: String {
        
        switch self{
            
        case .playList: return "/v1.1/new-hits-playlists/DZrC8m29ciOFY2JAm3/tracks?territory=TW"

        }
    }
    
    
}
