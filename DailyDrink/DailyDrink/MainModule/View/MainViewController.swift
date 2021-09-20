//
//  MainViewController.swift
//  DailyCocktail
//
//  Created by Никита Чирухин on 20.08.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol!
    
    private let cellId = "Cell"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 130
        tableView.backgroundColor = .navBlack
        return tableView
    }()

    var indicatorActivity = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupActivityIndicator()
        indicatorActivity.startAnimating()
    }

    private func setupView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    func setupActivityIndicator() {
        indicatorActivity.style = .large
        indicatorActivity.backgroundColor = .navBlack
        indicatorActivity.color = .white
        tableView.addSubview(indicatorActivity)
        indicatorActivity.frame = view.frame
    }
    
    

}
//MARK: Main TableView configuration
extension MainViewController: MainViewProtocol {
    
    func success() {
        tableView.reloadData()
        indicatorActivity.stopAnimating()
        indicatorActivity.hidesWhenStopped = true
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }

}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.drinks.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainTableViewCell
        cell.drinkImageView.image = presenter.makeImage(img: presenter.drinks[indexPath.row].image)
        cell.nameLabel.text = presenter.drinks[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drink = presenter.drinks[indexPath.row]
        presenter.tapOnTheDrink(id: drink.id)
    }
}
