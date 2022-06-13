//
//  DetailEventsViewController.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 13/06/2022.
//

import UIKit

class DetailEventsViewController: UIViewController {

    //MARK: - Properties
    
    var eventsComics = [Comics]()
    
    required init(model: Character, date: String) {
        super.init(nibName: nil, bundle: nil)
        setupUI(model: model)
        loadImage(model: model)
        setupDate(date: date)
    }
    
    private func setupDate(date: String){
        DispatchQueue.main.async{ [weak self] in
            self?.captionLabel.text = date
        }
    }
    private func setupUI(model: Character){
        DispatchQueue.main.async { [weak self] in
            self?.nameLabel.text = model.title?.uppercased()
            self?.eventsComics = model.comics.items
        }
    }
    
    private func loadImage(model: Character){
        guard let urlString = URL(string: "\(model.thumbnail?.path ?? "").\(model.thumbnail?.thumbnailExtension ?? "")") else {return}
        DispatchQueue.main.async { [weak self] in
            self?.frontImageView.load(url: urlString)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var contenViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.frame = self.view.bounds
        scroll.contentSize = contenViewSize
        scroll.autoresizingMask = .flexibleHeight
        scroll.showsHorizontalScrollIndicator = true
        scroll.bounces = true
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contenViewSize
        return view
    }()
    
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
    
    private var comicsToDiscussLabel: UILabel = {
          let label = UILabel()
          label.text = "COMICS TO DISCUSS"
          label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
          label.textColor = .black
          return label
      }()
    
    lazy var eventsFeedTable: UITableView = {
        let table = UITableView()
        table.register(ReusableTableViewCell.self, forCellReuseIdentifier: ReusableTableViewCell.identifier)
        table.showsVerticalScrollIndicator = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupViews()

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    func setupViews(){
        contentView.addSubview(frontImageView)
        contentView.addSubview(comicsToDiscussLabel)
        contentView.addSubview(eventsFeedTable)
        
        frontImageView.anchor(left: contentView.leftAnchor,paddingTop: 200, paddingLeft: 20)
        frontImageView.setDimensions(height: 100, width: 100)
        
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, captionLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        contentView.addSubview(stack)
        
        stack.anchor(top: contentView.topAnchor, left: frontImageView.rightAnchor, right: contentView.rightAnchor, paddingTop: 30, paddingLeft: 12 )
       
        comicsToDiscussLabel.anchor(top: stack.bottomAnchor, paddingTop: 60)
        comicsToDiscussLabel.centerX(inView: contentView)
       
        eventsFeedTable.anchor(top: comicsToDiscussLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 40)
        eventsFeedTable.setDimensions(height: 500, width: contentView.frame.width)
        
        
    }
}

//MARK: - Delegate & Datasource

extension DetailEventsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsComics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableTableViewCell.identifier, for: indexPath) as? ReusableTableViewCell
        else {
            return UITableViewCell()
        }
        let event = eventsComics[indexPath.row].name
        cell.configureCell(with: event )

        return cell
    }
}
