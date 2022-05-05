//
//  CharactersModelData.swift
//  MarvelData
//
//  Created by Swapnali Patil on 19/04/22.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let charactersResponce = try? newJSONDecoder().decode(CharactersResponce.self, from: jsonData)


// MARK: - CharactersResponce
struct CharactersResponce: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [ResultCharacters]
}

// MARK: - Result
struct ResultCharacters: Codable {
    let id: Int
    let name, resultDescription: String
    let modified: Date
    let thumbnail: Thumbnail
    let resourceURI: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
       case modified, thumbnail, resourceURI
    }
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: ItemType
}

enum ItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String

    enum CodingKeys: String, CodingKey {
        case path
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
