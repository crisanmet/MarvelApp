//
//  Test_Character_ViewModel.swift
//  MarvelAppTests
//
//  Created by Cristian Sancricca on 14/06/2022.
//

import XCTest
@testable import MarvelApp

class Test_Character_ViewModel: XCTestCase {

    var sut: CharacterViewModel!
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_CharacterViewModel_GetsCharacterData_ShouldReturnData(){
        let mock = MockCharacterServiceSuccess()
        sut = CharacterViewModel(characterService: mock)
        let expectation = XCTestExpectation(description: "Should return data")
        
        sut.characterService.fetchCharacter(pageNumber: 1) { character in
            XCTAssertNotNil(character)
            expectation.fulfill()
        } onError: { error in
            XCTAssertTrue(error.isEmpty)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }

    func test_characterViewModel_GetsCharacterData_ShouldShowError(){
        let mock = MockCharacterServiceFail()
        sut = CharacterViewModel(characterService: mock)
        
        let expectation = XCTestExpectation(description: "Should return error")
        
        sut.characterService.fetchCharacter(pageNumber: 1) { character in
            XCTAssertNil(character)
            expectation.fulfill()
        } onError: { error in
            XCTAssertEqual(error, "The Character service is not available")
            expectation.fulfill()
        }


        wait(for: [expectation], timeout: 3)
        
    }

}
