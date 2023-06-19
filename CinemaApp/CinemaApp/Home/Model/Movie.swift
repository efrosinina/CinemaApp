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
    let poster_path: String?
    let title: String?
    let vote_average: Double?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let original_name: String?
    let  youtubeView: VideoResponseModel?
}

