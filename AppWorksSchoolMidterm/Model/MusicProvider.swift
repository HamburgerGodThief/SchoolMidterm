//
//  MusicProvider.swift
//  AppWorksSchoolMidterm
//
//  Created by Hamburger on 2020/1/17.
//  Copyright © 2020 Hamburger. All rights reserved.
//

import Foundation

class MusicProvider {
    
    let musicRequest = MusicRequest.playList
    let decoder = JSONDecoder()
    
    func getMusic(completion: @escaping (Result<Music>) -> Void) {
        
        HTTPClient.shared.request(musicRequest, completion: { [weak self] result in
                
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
}
