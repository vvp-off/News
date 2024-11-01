//
//  ImageService.swift
//  WorldNewsApp
//
//  Created by Alexander Bokhulenkov on 25.10.2024.
//

import UIKit

final class ImageService {
    static let cache: NSCache<NSURL, NSData> = {
        let cache = NSCache<NSURL, NSData>()
        cache.countLimit = 10
        return cache
    }()
    
    static let imageSessions = URLSession.shared
    
    static func downloadImage(by urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        
        if let imageData = cache.object(forKey: url as NSURL) {
            return UIImage(data: imageData as Data)
        }
        
        let imageDataResponse = try await imageSessions.data(from: url)
        cache.setObject(imageDataResponse.0 as NSData, forKey: url as NSURL)
        
        return UIImage(data: imageDataResponse.0)
    }
}
