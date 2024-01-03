//
//  Container.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 13.07.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

class Container {
    static let jsonDecoder: JSONDecoder = JSONDecoder()
    
    static var weatherJSONDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return jsonDecoder
    }()
    
    /// News API key url: https://newsapi.org
//    static let newsAPIKey: String = "YOUR_API_KEY"
    static let newsAPIKey: String = "97ce7a5d32094e3da428c47a3c61d3ff"
    
    /// Weather API key url: https://darksky.net
    static let weatherAPIKey: String = "YOUR_API_KEY"
}
