//
//  ListCollectionViewCell.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 10/06/2022.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ListCollectionViewCell"
    
    private let frontImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFill
         imageView.clipsToBounds = true
         imageView.isUserInteractionEnabled = true
         return imageView
     }()
     
     private let nameLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
         label.textColor = .black
         label.numberOfLines = 1
         label.lineBreakMode = .byWordWrapping
         label.adjustsFontSizeToFitWidth = true
         label.sizeToFit()
         return label
     }()

    private var captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        addSubview(frontImageView)
        frontImageView.anchor(top: topAnchor, left: leftAnchor)
        frontImageView.setDimensions(height: 150, width: 150)
        
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, captionLabel])
         stack.axis = .vertical
         stack.spacing = 8
         stack.alignment = .leading
         addSubview(stack)

        stack.anchor(top: topAnchor, left: frontImageView.rightAnchor, right: contentView.rightAnchor, paddingTop: 30, paddingLeft: 12 )
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with model:Character){
        guard let urlString = URL(string: "\(model.thumbnail?.path ?? "").\(model.thumbnail?.thumbnailExtension ?? "")") else {return}
        DispatchQueue.main.async { [weak self] in
            self?.frontImageView.load(url: urlString)
            self?.nameLabel.text = model.name?.uppercased()
            self?.captionLabel.text = model.resultDescription?.description.maxLength(length: 20)
        }
    }
}
