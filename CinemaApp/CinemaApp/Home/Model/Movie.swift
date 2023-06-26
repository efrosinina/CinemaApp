//
//  Movie.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import Foundation

struct Movie: Codable {
    let adult: Bool?
    let id: Int?
    let posterPath: String?
    let title: String?
    let voteAverage: Double?
    let overview: String?
    let voteCount: Int
    let releaseDate: String?
    let originalName: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case overview
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case originalName = "original_name"
    }
}
