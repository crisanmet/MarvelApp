//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 10/06/2022.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    var characterComics = [Comics]()
    
    required init(model: Character) {
        super.init(nibName: nil, bundle: nil)
        setupUI(model: model)
        loadImage(model: model)
    }
    
    private func setupUI(model: Character){
        DispatchQueue.main.async { [weak self] in
            self?.title = model.name
            self?.captionLabel.text = model.resultDescription?.description
            self?.characterComics = model.comics.items
        }
    }
    
    private func loadImage(model: Character){
        guard let urlString = URL(string: "\(model.thumbnail?.path ?? "").\(model.thumbnail?.thumbnailExtension ?? "")") else {return}
        DispatchQueue.main.async { [weak self] in
            self?.frontImage.load(url: urlString)
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
    
    private var frontImage: UIImageView = {
          let imageView = UIImageView()
          imageView.contentMode = .scaleAspectFill
          imageView.clipsToBounds = true
          return imageView
      }()
    
    private var captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    private var appearsLabel: UILabel = {
          let label = UILabel()
          label.text = "APPEARS IN THESE COMICS"
          label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
          label.textColor = .black
          return label
      }()

    lazy var comicsFeedTable: UITableView = {
        let table = UITableView()
        table.register(ReusableTableViewCell.self, forCellReuseIdentifier: ReusableTableViewCell.identifier)
        table.rowHeight = 50
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    func setupViews(){
        contentView.addSubview(frontImage)
        contentView.addSubview(captionLabel)
        contentView.addSubview(appearsLabel)
        contentView.addSubview(comicsFeedTable)
        
        frontImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor)
        frontImage.setDimensions(height: 400, width: contentView.frame.width)
       
       captionLabel.anchor(top: frontImage.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 12, paddingLeft: 12,paddingRight: 12)
       
        appearsLabel.anchor(top: captionLabel.bottomAnchor, paddingTop: 20)
        appearsLabel.centerX(inView: contentView)
       
        comicsFeedTable.anchor(top: appearsLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 40)
        comicsFeedTable.setDimensions(height: 500, width: contentView.frame.width)
        
        
    }
    
 
    

    public func configureDetail(with model:Character){
        guard let urlString = URL(string: "\(model.thumbnail?.path ?? "").\(model.thumbnail?.thumbnailExtension ?? "")") else {return}
        DispatchQueue.main.async { [weak self] in
            self?.title = model.name
            self?.frontImage.load(url: urlString)
            self?.captionLabel.text = model.resultDescription?.description

        }
    }

}

//MARK: - Table Delegate & Datasource

extension CharacterDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterComics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableTableViewCell.identifier, for: indexPath) as? ReusableTableViewCell
        else {
            return UITableViewCell()
        }
        let comics = characterComics[indexPath.row].name
        cell.configureCell(with: comics)

        return cell
    }
}
