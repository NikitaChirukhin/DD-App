//
//  FavoritViewController.swift
//  DailyCoctail
//
//  Created by Никита Чирухин on 02.09.2021.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var presenter: FavoritePresenterProtocol!
    
    var favoriteTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
    }
}

extension FavoriteViewController: FavoriteViewProtocol {
    
    func success() {
    
    }
    
    func failure(error: Error) {
        
    }
    
    
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}

extension FavoriteViewController: UITableViewDelegate {
    
}
