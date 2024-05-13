//
//  ImageDownloader.swift
//  GameCatalog
//
//  Created by Mahatmaditya FRS on 13/05/24.
//

import Foundation
import UIKit

class ImageDownloader {
    
    func downloadImage(url: URL) async throws -> UIImage {
        async let imageData: Data = try Data(contentsOf: url)
        
        return UIImage(data: try await imageData)!
    }
    
}
