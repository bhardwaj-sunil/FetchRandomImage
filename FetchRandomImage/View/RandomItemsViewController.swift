//
//  ViewController.swift
//  FetchRandomImage
//
//  Created by Neel Kumar on 24/08/25.
//

import UIKit
import Kingfisher

class RandomItemsViewController: UITableViewController {

    private let viewModel = RandomItemsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title  = "Random items"
        addNavigations()
        updateView()
    }
    
    // MARK: TableView override methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.randomItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nativeCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "nativeCell")
        
        let item = viewModel.randomItems[indexPath.row]
        
        cell.textLabel?.text = item.author
        cell.detailTextLabel?.text = "ID: \(item.id)"
        cell.imageView?.kf.setImage(with: item.download_url, placeholder: UIImage(systemName: "photo")) { _ in
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
            cell.imageView?.frame.size = CGSize(width: 60, height: 60)
            cell.setNeedsLayout()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteRandomITem(at: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    //MARK: Private methods
    
    private func addNavigations() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRandomItem))
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    private func updateView() {
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // Add Random Item
    @objc private func addRandomItem() {
        Task { await viewModel.addRandom() }
    }
}

