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
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Float
    
    var state: DownloadState = .new
    
    init(name: String, released: String, backgroundImage: String, rating: Float) {
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
    }
}

struct GameResponse: Codable {
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Float
    
    enum CodingKeys: String, CodingKey {
        case name
        case released
        case backgroundImage = "background_image"
        case rating
    }
}

struct GameResponses: Codable {
    let games: [GameResponse]
    
    enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}
