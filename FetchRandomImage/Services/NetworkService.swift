//
//  NetworkService.swift
//  FetchRandomImage
//
//  Created by Neel Kumar on 24/08/25.
//

import Foundation

class NetworkService {
    func fetchRandomItems() async throws -> [RandomItem] {
        
        // URL
        let url = URL(string: "https://picsum.photos/v2/list")!
        
        // API call
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else { throw URLError(.badServerResponse) }
        
        // Decode response
        let itemDTO = try JSONDecoder().decode([RandomItemDTO].self, from: data)
        
        // convert to domain model
        return itemDTO.compactMap { itemDTO in
            itemDTO.toModel()
        }
    }
}
