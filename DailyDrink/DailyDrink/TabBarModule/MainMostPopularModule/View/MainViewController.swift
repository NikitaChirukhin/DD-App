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
    
    lazy var errorView: UILabel = {
        let errorView = UILabel()
        errorView.frame = view.bounds
        errorView.text = ""
        errorView.backgroundColor = .lightBlack
        errorView.textAlignment = .center
        errorView.numberOfLines = 4
        errorView.textColor = .white
        errorView.font = UIFont(name: "IowanOldStyle-Roman", size: 40)
        return errorView
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
        view.addSubview(errorView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        let goldenEggButton = UIBarButtonItem.init(image: UIImage(systemName: "placeholdertext.fill"), style: .done, target: self, action: #selector(goldenEgg))
        goldenEggButton.accessibilityIdentifier = "goldenEggButton"
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.rightBarButtonItem = goldenEggButton
        navigationItem.rightBarButtonItem?.tintColor = .navBlack
    }
    
    @objc private func goldenEgg() {
        let alert = UIAlertController(title: "GOLDEN EGG", message: "Your name: \(GoldenEgg.getName())", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your Name"
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields!
            let name = textField?.first?.text ?? ""
            GoldenEgg.setName(name: name)
        }))

        self.present(alert, animated: true, completion: nil)
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
        errorView.isHidden = true
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
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TableViewCell {
            cell.drinkImageView.image = presenter.makeImage(img: presenter.drinks[indexPath.row].image)
            cell.nameLabel.text = presenter.drinks[indexPath.row].name
            cell.selectionStyle = .none
            cell.accessibilityIdentifier = "currentTableViewCell"
            return cell
        }
        return UITableViewCell()
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drink = presenter.drinks[indexPath.row]
        presenter.tapOnTheDrink(id: drink.id)
    }
}
