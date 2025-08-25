//
//  Item.swift
//  FetchRandomImage
//
//  Created by Neel Kumar on 24/08/25.
//

import Foundation

// API Data transfer object
struct RandomItemDTO: Decodable {
    let id: String
    let author: String
    let download_url: String
    
    func toModel() -> RandomItem? {
        guard let url = URL(string: download_url) else { return nil }
        return RandomItem(id: id, author: author, download_url: url)
    }
}

// Domain model
struct RandomItem: Identifiable, Codable, Equatable {
    let id: String
    let author: String
    let download_url: URL
}
