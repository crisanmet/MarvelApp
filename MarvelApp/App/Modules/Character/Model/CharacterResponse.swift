//
//  CharacterResponse.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 09/06/2022.
//

import Foundation

struct CharacterResponse: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataClass
}

struct DataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [Character]
}

struct Character: Codable {
    let id: Int?
    let title: String?
    let name, resultDescription: String?
    let thumbnail: Thumbnail?
    let modified: String?
    let start, end: String?
    let creators: Creators?
    let characters: Description?
    let resourceURI: String?
    let comics, series: Description
    let stories: Stories?
    let events: Description?
    let urls: [URLElement]?
    let next, previous: Comics?

    enum CodingKeys: String, CodingKey {
        case id, name, title
        case resultDescription = "description"
        case thumbnail, resourceURI, comics, series, stories, events, urls, modified, start, end, creators, characters, next, previous
    }
}

struct Description: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Comics]
    let returned: Int?
}

struct Comics: Codable {
    let resourceURI: String
    let name: String
}

struct Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

struct StoriesItem: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?
}

struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

struct Creators: Codable {
    let resourceURI: String?
    let name: String?
    let role: String?
}

struct URLElement: Codable {
    let type: String?
    let url: String?
}
