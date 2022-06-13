//
//  CharacterViewModel.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 10/06/2022.
//

import Foundation
import UIKit


protocol CharacterViewModelDelegate: AnyObject {
    func didGetCharacterData()
    func didFailGettingCharacterData(error: String)
    func showLoading()
    func hideLoading()
}

protocol ComicsViewModelDelegate: AnyObject {
    func didGetComicsData()
}

class CharacterViewModel{
    
    weak var delegate: CharacterViewModelDelegate?
    
    weak var comicsDelegate: ComicsViewModelDelegate?
    
    var characters = [Character]()
    
    var characterComics = [Comics]()
    
    var characterService: CharacterFetching
    
    init(characterService: CharacterFetching = CharacterService()) {
        self.characterService = characterService
    }
    
    func getCharacters(pageNumber: Int = 1){
        self.loadingView(.show)
        DispatchQueue.global().async { [weak self] in
            self?.characterService.fetchCharacter(pageNumber: pageNumber, onComplete: { character in
                self?.characters.append(contentsOf: character.data.results)
                self?.delegate?.didGetCharacterData()
                self?.loadingView(.hide)
            }, onError: { error in
                self?.delegate?.didFailGettingCharacterData(error: error)
                self?.loadingView(.hide)
            })
        }
    }
    
    func getCharacter(at index:Int) -> Character{
        return characters[index]
    }
    
    func getCharacterCount() -> Int{
        return characters.count
    }
    
    func saveComics(to character:Character){
        self.characterComics = character.comics.items
        self.comicsDelegate?.didGetComicsData()
    }
    
    func getComics(at index: Int) -> String {
        return characterComics[index].name
    }
    
    func getComicsCount() -> Int{
        print(characterComics.count)
        return characterComics.count
    }
    
    func loadingView(_ state: LoadingViewState){
        switch state {
        case .show:
            self.delegate?.showLoading()
        case .hide:
            self.delegate?.hideLoading()
        }
    }
}
