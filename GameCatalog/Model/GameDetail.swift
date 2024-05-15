//
//  GameDetail.swift
//  GameCatalog
//
//  Created by Mahatmaditya FRS on 15/05/24.
//

import Foundation
import UIKit

class GameDetail {
    let id: Int
    let name: String
    let description: String
    let rating: Float
    let backgroundImage: URL
    let genre: [Genre]
    
    init(id: Int, name: String, description: String, rating: Float, backgroundImage: URL, genre: [Genre]) {
        self.id = id
        self.name = name
        self.description = description
        self.rating = rating
        self.backgroundImage = backgroundImage
        self.genre = genre
    }
}

struct GameDetailResponse: Codable {
    let id: Int
    let name: String
    let description: String
    let rating: Float
    let backgroundImage: URL
    let genre: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case rating
        case backgroundImage = "background_image"
        case genre
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.rating = try container.decode(Float.self, forKey: .rating)
        self.backgroundImage = try container.decode(URL.self, forKey: .backgroundImage)
        self.genre = try container.decode([Genre].self, forKey: .genre)
    }
}


struct Genre: Codable {
    let id: Int
    let name: String
    let slug: String
    let gamesCount: Int
    let imageBackground: String
    
    enum CodingKeys: String, CodingKey {
           case id
           case name
           case slug
           case gamesCount = "games_count"
           case imageBackground = "image_background"
       }
}
