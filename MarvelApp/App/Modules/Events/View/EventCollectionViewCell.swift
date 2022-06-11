//
//  EventCollectionViewCell.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 11/06/2022.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EventCollectionViewCell"
    
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
        setupCornersImage()
        contentView.backgroundColor = .white
        
        addSubview(frontImageView)
        frontImageView.anchor(left: leftAnchor,paddingLeft: 20)
        frontImageView.centerY(inView: contentView)
        frontImageView.setDimensions(height: 100, width: 100)
        
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, captionLabel])
         stack.axis = .vertical
         stack.spacing = 8
         stack.alignment = .leading
         addSubview(stack)

        stack.anchor(top: topAnchor, left: frontImageView.rightAnchor, right: contentView.rightAnchor, paddingTop: 30, paddingLeft: 12 )
        

    }
    func setupCornersImage(){
        DispatchQueue.main.async { [weak self] in
            self?.frontImageView.roundCorners([.topLeft, .bottomLeft], radius: 8)
            self?.frontImageView.layer.masksToBounds = true
        }
    }
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with model:Character){
        guard let urlString = URL(string: "\(model.thumbnail?.path ?? "").\(model.thumbnail?.thumbnailExtension ?? "")") else {return}
        DispatchQueue.main.async { [weak self] in
            self?.frontImageView.load(url: urlString)
            self?.nameLabel.text = model.title?.uppercased()
            guard let safeData = model.start else { return}
            self?.captionLabel.text = safeData
        }
    }
}
