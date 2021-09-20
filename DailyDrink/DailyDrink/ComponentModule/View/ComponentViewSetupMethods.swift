//
//  ComponentViewSetupMethods.swift
//  DailyCoctail
//
//  Created by Никита Чирухин on 14.09.2021.
//
import UIKit

extension ComponentViewController {
    
    func mainStackViewSetup() {
    
        let mainStackViewItem = [nameLabel, afterNameStackView]

        mainStackViewItem.forEach { mainStackView.addArrangedSubview($0) }
        
    }
    
    func setupSpecBlock() {
        
        let glassStackItem = [glassLabel, glassLabelContent]
        let drinkTypeStackItem = [drinkTypeLabel, drinkTypeLabelContent]
        let specStackViewItem = [glassStack, drinkTypeStack]
        let topSpecStackLabels = [glassLabel, drinkTypeLabel]
        let bottomSpecStackLabels = [glassLabelContent, drinkTypeLabelContent]
        
        
        specStackViewItem.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .vertical
            $0.spacing = 15
            $0.alignment = .center
            afterNameStackView.addArrangedSubview($0)
        }

        glassStackItem.forEach {
            glassStack.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        drinkTypeStackItem.forEach {
            drinkTypeStack.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        topSpecStackLabels.forEach {
            $0.textColor = .systemGray
            $0.font = UIFont(name: "IowanOldStyle-Roman", size: 15)
        }
        
        bottomSpecStackLabels.forEach({
            $0.textColor = .systemYellow
            $0.font = UIFont(name: "IowanOldStyle-Roman", size: 20)
            $0.numberOfLines = 2
        })
        
        drinkTypeLabel.text = "Category"
        glassLabel.text = "Glass"
    }
    
    func setupRecipeStackView() {
        recipeStackView.addArrangedSubview(recipeLabel)
        recipeStackView.addArrangedSubview(recipeInstruction)
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 128.0/255.0, green: 0.0/255.0, blue: 128.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 23.0/255.0, green: 22.0/255.0, blue: 28.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setupConstraint() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            drinkImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            drinkImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            drinkImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            drinkImageView.heightAnchor.constraint(equalToConstant: view.frame.width),
            
            mainStackView.topAnchor.constraint(equalTo: drinkImageView.bottomAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10),
            mainStackView.heightAnchor.constraint(equalToConstant: 150),
            
            ingredientStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 35),
            ingredientStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            ingredientStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            ingredientStackView.heightAnchor.constraint(equalToConstant: 180),
            
            recipeStackView.topAnchor.constraint(equalTo: ingredientStackView.bottomAnchor, constant: 35),
            recipeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            recipeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            recipeStackView.heightAnchor.constraint(equalToConstant: 180),
        ])
    }
}
