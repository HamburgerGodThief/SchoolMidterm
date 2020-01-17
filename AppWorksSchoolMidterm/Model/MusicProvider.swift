//
//  MusicProvider.swift
//  AppWorksSchoolMidterm
//
//  Created by Hamburger on 2020/1/17.
//  Copyright © 2020 Hamburger. All rights reserved.
//

import Foundation

class MusicProvider {
    
    let decoder = JSONDecoder()
    
    func getMusic(request: MusicRequest, completion: @escaping (Result<Music>) -> Void) {
        
        HTTPClient.shared.request(request, completion: { [weak self] result in
                
                guard let strongSelf = self else { return }
                
                switch result {
                    
                case .success(let data):
                    
                    do {
                        let response = try strongSelf.decoder.decode(Music.self, from: data)
                        
                        DispatchQueue.main.async {
                            
                            completion(Result.success(response))
                        }
                        
                    } catch {
                        
                        completion(Result.failure(error))
                    }
                    
                case .failure(let error):
                    
                    completion(Result.failure(error))
                }
        })
    }
    
    func login(request: MusicRequest, completion: @escaping (Result<User>) -> Void) {
        
        HTTPClient.shared.login(request, completion: { [weak self] result in
                
                guard let strongSelf = self else { return }
                
                switch result {
                    
                case .success(let data):
                    
                    do {
                        let response = try strongSelf.decoder.decode(User.self, from: data)
                        
                        DispatchQueue.main.async {
                            
                            completion(Result.success(response))
                        }
                        
                    } catch {
                        
                        completion(Result.failure(error))
                    }
                    
                case .failure(let error):
                    
                    completion(Result.failure(error))
                }
        })
    }
}
