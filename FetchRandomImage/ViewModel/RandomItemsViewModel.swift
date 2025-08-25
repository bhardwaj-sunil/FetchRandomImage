//
//  RandomItemsViewModel.swift
//  FetchRandomImage
//
//  Created by Neel Kumar on 24/08/25.
//

import Foundation

@MainActor
final class RandomItemsViewModel {
    private(set) var randomItems: [RandomItem] = []
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func addRandom() async {
        do {
            let allItems = try await networkService.fetchRandomItems()
            guard let random = allItems.randomElement() else { return }
            randomItems.append(random)
            print("List of random Items: \(randomItems)")
        } catch {
            print("Error fetchig: \(error)")
        }
    }
}
