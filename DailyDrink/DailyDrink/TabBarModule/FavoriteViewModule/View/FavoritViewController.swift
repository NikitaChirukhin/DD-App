//
//  FavoritViewController.swift
//  DailyCoctail
//
//  Created by Никита Чирухин on 02.09.2021.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var presenter: FavoritePresenterProtocol!
    
    private let cellId = "Cell"
    
    let refreshControl = UIRefreshControl()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.rowHeight = 130
        tableView.backgroundColor = .navBlack
        return tableView
    }()
    
    lazy var errorView: UILabel = {
        let errorView = UILabel()
        errorView.frame = view.bounds
        errorView.text = "Nothing found"
        errorView.backgroundColor = .lightBlack
        errorView.textAlignment = .center
        errorView.numberOfLines = 4
        errorView.textColor = .white
        errorView.font = UIFont(name: "IowanOldStyle-Roman", size: 40)
        return errorView
    }()
    
    lazy var searchController = UISearchController()

    var indicatorActivity = UIActivityIndicatorView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavigationBar()
        setupView()
        setupActivityIndicator()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationItem.searchController = searchController
    }
    
    func setupView() {
        view.addSubview(tableView)
        view.addSubview(errorView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    func setupActivityIndicator() {
        indicatorActivity.style = .large
        indicatorActivity.backgroundColor = .navBlack
        indicatorActivity.color = .white
        tableView.addSubview(indicatorActivity)
        indicatorActivity.frame = view.frame
    }
    
    func setupNavigationBar() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Enter drink name.."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
    }
}

extension FavoriteViewController: FavoriteViewProtocol {
    
    func success() {
        tableView.reloadData()
        errorView.isHidden = true
        indicatorActivity.stopAnimating()
    }
    
    func failure(error: Error) {
        errorView.isHidden = false
        errorView.text = "Nothing found"
        indicatorActivity.stopAnimating()
    }
}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.tapOnTheDrink(id: presenter.drinks[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TableViewCell {
            cell.selectionStyle = .none
    
            return cell
        }
        return UITableViewCell()
    }

}


extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

extension FavoriteViewController: UISearchResultsUpdating, UISearchBarDelegate {
   
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            indicatorActivity.startAnimating()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        presenter.searchDrinks(request: searchBar.text)
        indicatorActivity.startAnimating()
    }
}
