//
//  Movie.swift
//  OMDB-Demo
//
//  Created by Dhanshree Nagre on 15/01/20.
//  Copyright © 2020 Dhanshree Nagre. All rights reserved.
//
import Foundation

class Search: Codable {
    let search: [Movie]

    init(search: [Movie]) {
        self.search = search
    }

    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

class Movie: Codable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String

    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }

    init(title: String, year: String, imdbID: String, type: String, poster: String) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.poster = poster
    }
}
