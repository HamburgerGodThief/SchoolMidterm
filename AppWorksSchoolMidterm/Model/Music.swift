//
//  MusicData.swift
//  AppWorksSchoolMidterm
//
//  Created by Hamburger on 2020/1/17.
//  Copyright © 2020 Hamburger. All rights reserved.
//

import Foundation

class MusicSelect {
    
    let url: String
    let songName: String
    var selectStatus: Bool
    
    init(url: String, songName: String, selectStatus: Bool) {
        self.url = url
        self.songName = songName
        self.selectStatus = selectStatus
    }
}

struct Music: Codable {
    
    let data: [MusicData]
    let paging: Paging
    let summary: Summary
    
}

struct MusicData: Codable {
    let id: String
    let name: String
    let duration: Int
    let isrc: String
    let url: String
    let trackNumber: Int
    let explicitness: Bool
    let availableTerritories: [String]
    let album: Album
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case duration
        case isrc
        case url
        case trackNumber = "track_number"
        case explicitness
        case availableTerritories = "available_territories"
        case album
        
    }
    
}

struct Album: Codable {
    
    let id: String
    let name: String
    let url: String
    let explicitness: Bool
    let availableTerritories: [String]
    let releaseDate: String
    let images: [Images]
    let artist: Artist
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case url
        case explicitness
        case availableTerritories = "available_territories"
        case releaseDate = "release_date"
        case images
        case artist
        
    }
}

struct Images: Codable {
    
    let height: Int
    let width: Int
    let url: String
    
}

struct Artist: Codable {
    
    let id: String
    let name: String
    let url: String
    let images: [Images]
    
}

struct Paging: Codable {
    
    let offset: Int
    let limit: Int
    
}

struct Summary: Codable {
    
    let total: Int
    
}

