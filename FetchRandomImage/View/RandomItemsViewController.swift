//
//  ViewController.swift
//  FetchRandomImage
//
//  Created by Neel Kumar on 24/08/25.
//

import UIKit

class RandomItemsViewController: UIViewController {

    let viewModel = RandomItemsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title  = "Random items"
        
        AddRandomItem()
        
    }
    
    // Add Random Item
    private func AddRandomItem() {
        Task { await viewModel.addRandom() }
    }

}

