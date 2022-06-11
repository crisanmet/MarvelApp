//
//  CharacterViewController.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 09/06/2022.
//

import UIKit

class CharacterViewController: UIViewController {

    
    
    //MARK: - Properties
    
    lazy var viewModel: CharacterViewModel = {
        let characterViewModel = CharacterViewModel()
        characterViewModel.delegate = self
        return characterViewModel
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero    , collectionViewLayout: layout)
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 10
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        collectionView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        collectionView.layer.shadowOpacity = 1.0
        collectionView.layer.shadowRadius = 2.0
        collectionView.layer.masksToBounds = false
        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,  right: view.rightAnchor, paddingLeft: 12, paddingRight: 12)

        viewModel.getCharacters()
    }
    
    //MARK: - Helpers
    
    func showMessageError(message: String){
            let alert = UIAlertController(title: "Fail", message: message, preferredStyle: .alert)
            let actionRetry = UIAlertAction(title: "Retry?", style: .default) { [weak self] _ in
                self?.viewModel.getCharacters()
            }
            let actionCancel = UIAlertAction(title: "Cancel", style: .destructive)
            
            alert.addAction(actionRetry)
            alert.addAction(actionCancel)
            
            present(alert, animated: true)
        }
}


//MARK: - Character Delegate

extension CharacterViewController: CharacterViewModelDelegate {
    func didGetCharacterData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.isHidden = false
            self?.collectionView.reloadData()
        }
    }
    
    func didFailGettingCharacterData(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.isHidden = true
            self?.showMessageError(message: error)
        }
    }
}

//MARK: - Collection Delegate & Datasource

extension CharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 390, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowRadius = 2.0
        cell.layer.masksToBounds = false
        
        let character = viewModel.getCharacter(at: indexPath.row)
        cell.configureCell(with: character)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCharacterCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = CharacterDetailViewController()
        let character = viewModel.getCharacter(at: indexPath.row)
        detailVC.characterComics = character.comics.items
        detailVC.configureDetail(with: character)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
