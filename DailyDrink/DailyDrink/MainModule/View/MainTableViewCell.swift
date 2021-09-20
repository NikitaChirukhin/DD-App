//
//  MainTableViewCell.swift
//  DailyCocktail
//
//  Created by Никита Чирухин on 01.09.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    let drinkImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.layer.cornerRadius = 60
        image.clipsToBounds = true
        image.backgroundColor = .lightBlack
        return image
    }()
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .white
        name.font = UIFont(name: "IowanOldStyle-Roman", size: 25)
        name.backgroundColor = .lightBlack
        name.numberOfLines = 2
        return name
    }()
    
    func setupView() {
        
        backgroundColor = .lightBlack
        addSubview(drinkImageView)
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            drinkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            drinkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            drinkImageView.heightAnchor.constraint(equalToConstant: 120),
            drinkImageView.widthAnchor.constraint(equalToConstant: 120),
            nameLabel.leadingAnchor.constraint(equalTo: drinkImageView.trailingAnchor, constant: 25),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
