//
//  ComponentViewController.swift
//  DailyCocktail
//
//  Created by Никита Чирухин on 27.08.2021.
//

import UIKit

class ComponentViewController: UIViewController {
    
    var presenter: ComponentViewPresenterProtocol!

    let drinkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.width + 750)
        return scrollView
    }()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "IowanOldStyle-Roman", size: 33)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    let ingredientLabel: UILabel = {
        let ingredientLabel = UILabel()
        ingredientLabel.font = UIFont(name: "IowanOldStyle-Roman", size: 25)
        ingredientLabel.textColor = .systemGray
        ingredientLabel.text = "Ingredients"
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientLabel
    }()
    
    let recipeLabel: UILabel = {
        let recipeLabel = UILabel()
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeLabel.font = UIFont(name: "IowanOldStyle-Roman", size: 25)
        recipeLabel.textColor = .systemGray
        recipeLabel.text = "Recipe"
        return recipeLabel
    }()
    
    let recipeInstruction: UILabel = {
        let recipeInstruction = UILabel()
        recipeInstruction.translatesAutoresizingMaskIntoConstraints = false
        recipeInstruction.textColor = .systemYellow
        recipeInstruction.numberOfLines = 10
        return recipeInstruction
    }()
    
    let afterNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let ingredientStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    let recipeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    let glassStack = UIStackView()
    let drinkTypeStack = UIStackView()
    let glassLabel = UILabel()
    let glassLabelContent = UILabel()
    let drinkTypeLabel = UILabel()
    let drinkTypeLabelContent = UILabel()
    
    
//MARK: Main Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @objc func popButtonAction() {
        presenter.popToRootViewController()
    }
    
    @objc func likeButtonAction() {
        presenter.saveDrinkToCoreData()
    }
 
    func setupView() {

        navigationBarItem()
        view.addSubview(scrollView)
        setupScrollView()
        setGradientBackground()
        mainStackViewSetup()
        setupSpecBlock()
        setupRecipeStackView()
        setupConstraint()
    }
    
    func navigationBarItem() {
        
        let likeBarButton = UIBarButtonItem.init(image: UIImage(systemName: "heart.circle"), style: .done, target: self, action: #selector(likeButtonAction))
        let popButton = UIBarButtonItem.init(image: UIImage(systemName: "arrow.backward.circle.fill"), style: .done, target: self, action: #selector(popButtonAction))
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.leftBarButtonItem = popButton
        navigationItem.rightBarButtonItem = likeBarButton
        navigationItem.leftBarButtonItem?.tintColor = .systemYellow
        navigationItem.rightBarButtonItem?.tintColor = .systemYellow
        navigationItem.hidesBackButton = true
    }
}

extension ComponentViewController: UIScrollViewDelegate {
    
    private func setupScrollView() {
        
        scrollView.delegate = self
        
        scrollView.addSubview(drinkImageView)
        scrollView.addSubview(mainStackView)
        scrollView.addSubview(ingredientStackView)
        scrollView.addSubview(recipeStackView)
    }
}

extension ComponentViewController: ComponentViewProtocol {

    func success() {
        nameLabel.text = presenter.drinkComponent?.name
        drinkImageView.image = presenter.drinkComponent?.image
        drinkTypeLabelContent.text = presenter.drinkComponent?.category
        glassLabelContent.text = presenter.drinkComponent?.glass
        setupIngredient()
        recipeInstruction.text = presenter.drinkComponent?.recipe
    }
    
    private func setupIngredient() {
        
        ingredientStackView.addArrangedSubview(ingredientLabel)
        var counter = 0
        presenter.drinkComponent?.ingredients.forEach({ ingredient in
            let labelIngredient = UILabel()
            counter += 1
            labelIngredient.text = "• \(ingredient.ingredient) \(ingredient.measure)"
            labelIngredient.textColor = .systemYellow
            ingredientStackView.addArrangedSubview(labelIngredient)
        })
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
