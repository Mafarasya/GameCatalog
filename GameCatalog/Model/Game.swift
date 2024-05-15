//
//  Game.swift
//  GameCatalog
//
//  Created by Mahatmaditya FRS on 11/05/24.
//

import Foundation
import UIKit

enum DownloadState {
    case new, downloaded, failed
}


class Game {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: URL
    let rating: Float
    
    var image: UIImage?
    var state: DownloadState = .new
    
    init(id: Int, name: String, released: String, backgroundImage: URL, rating: Float) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
    }
}

struct GameResponse: Codable {
    let id: Int
    let name: String
    let released: Date
    let backgroundImage: URL
    let rating: Float
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dateString = try container.decode(String.self, forKey: .released)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-DD"
        released = dateFormatter.date(from: dateString)!
        
        // another property
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        backgroundImage = try container.decode(URL.self, forKey: .backgroundImage)
        rating = try container.decode(Float.self, forKey: .rating)
    }
}

struct GameResponses: Codable {
    let games: [GameResponse]
    
    enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}
