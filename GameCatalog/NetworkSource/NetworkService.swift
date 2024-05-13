//
//  NetworkService.swift
//  GameCatalog
//
//  Created by Mahatmaditya FRS on 13/05/24.
//

import Foundation

class NetworkService {
    
    let apiKey = "df576ac0094546218110c4160d779724"
    
    func getGames() async throws -> [Game] {
        var components = URLComponents(string: "https://api.rawg.io/api/games")!
        
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetching data.")
        }
        
        // set up decoder
        let decoder = JSONDecoder()
        let result = try decoder.decode(GameResponses.self, from: data)
        
        return GameMapper(input: result.games)
        
    }
    
}

extension NetworkService {
    
    fileprivate func GameMapper(input gameResponses: [GameResponse]) -> [Game] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-DD"
        
        return gameResponses.map { result in
            
            let releasedDateString = dateFormatter.string(from: result.released)
            
            return Game(name: result.name,
                        released: releasedDateString,
                        backgroundImage: result.backgroundImage,
                        rating: result.rating)
        }
    }
    
}
