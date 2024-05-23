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
    let released: String
    
    var image: UIImage?

    init(id: Int, name: String, description: String, rating: Float, backgroundImage: URL, released: String) {
        self.id = id
        self.name = name
        self.description = description
        self.rating = rating
        self.backgroundImage = backgroundImage
        self.released = released
    }
}

struct GameDetailResponse: Codable {
    let id: Int
    let name: String
    let description: String
    let rating: Float
    let backgroundImage: URL
    let released: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description = "description_raw"
        case rating
        case backgroundImage = "background_image"
        case released
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dateString = try container.decode(String.self, forKey: .released)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-DD"
        released = dateFormatter.date(from: dateString)!
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.rating = try container.decode(Float.self, forKey: .rating)
        self.backgroundImage = try container.decode(URL.self, forKey: .backgroundImage)
    }
}
