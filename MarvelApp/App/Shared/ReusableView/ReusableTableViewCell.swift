//
//  ComicsTableViewCell.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 10/06/2022.
//

import UIKit

class ReusableTableViewCell: UITableViewCell {

    
    static let identifier = "ComicsTableViewCell"
    
    var comicName: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    override func layoutSubviews() {
        contentView.addSubview(comicName)
        comicName.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with model: String){
        DispatchQueue.main.async { [weak self] in
            self?.comicName.text = model
        }
    }
    
}
