//
//  CharacterViewModel.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 10/06/2022.
//

import Foundation

protocol CharacterViewModelDelegate: AnyObject {
    func didGetCharacterData()
    func didFailGettingCharacterData(error: String)
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
    
    func getCharacters(){
        DispatchQueue.global().async { [weak self] in
            self?.characterService.fetchCharacter(onComplete: { character in
                self?.characters = character.data.results
                self?.delegate?.didGetCharacterData()
            }, onError: { error in
                self?.delegate?.didFailGettingCharacterData(error: error)
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
    
    
}
