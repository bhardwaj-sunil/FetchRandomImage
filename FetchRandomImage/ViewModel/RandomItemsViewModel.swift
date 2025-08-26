//
//  RandomItemsViewModel.swift
//  FetchRandomImage
//
//  Created by Neel Kumar on 24/08/25.
//

import Foundation

@MainActor
final class RandomItemsViewModel {
    private let key = "saveRandomItems"
    private(set) var randomItems: [RandomItem] = []
    private let networkService: NetworkService
    
    var onUpdate: (() -> Void)?
    
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
        self.randomItems = loadRandomItems()
    }
    
    //MARK: Random Item Operations
    
    func addRandom() async {
        do {
            let allItems = try await networkService.fetchRandomItems()
            guard let random = allItems.randomElement() else { return }
            randomItems.append(random)
            saveRandomItems(randomItems)
            onUpdate?()
        } catch {
            print("Error fetchig: \(error)")
        }
    }
    
    func deleteRandomITem(at index: Int) {
        guard index < randomItems.count else { return }
        randomItems.remove(at: index)
        saveRandomItems(randomItems)
        onUpdate?()
    }
    
    func move(from source: Int, to destination: Int) {
        guard source < randomItems.count else { return }
        let move = randomItems.remove(at: source)
        randomItems.insert(move, at: destination)
        saveRandomItems(randomItems)
        onUpdate?()
    }
    
    // MARK: Local storage methods
    
    func loadRandomItems() -> [RandomItem] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        let randomItems = (try? JSONDecoder().decode([RandomItem].self, from: data)) ?? []
        return randomItems
    }
    
    func saveRandomItems(_ items: [RandomItem]) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
