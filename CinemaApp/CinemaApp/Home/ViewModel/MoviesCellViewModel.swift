//
//  MoviesCellViewModel.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import Foundation

struct MovieCellViewModel {
    let title: String?
    let poster_path: String?
    let overview: String?
    let vote_average: Double?
    
    init(movie: Movie) {
        overview = movie.overview
        vote_average = movie.vote_average
        title = movie.title
        poster_path = movie.poster_path
    }
}

