//
//  MoviesCellViewModel.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import Foundation

struct MovieCellViewModel {
    let id: Int?
    let title: String?
    let original_name: String?
    let poster_path: String?
    let overview: String?
    let vote_average: Double?
    let vote_count: Int
    var release_date: String?
    let youtubeView: VideoResponseModel?
    
    init(movie: Movie) {
        overview = movie.overview
        vote_average = movie.vote_average
        title = movie.title
        poster_path = movie.poster_path
        vote_count = movie.vote_count
        release_date = movie.release_date
        id = movie.id
        original_name = movie.original_name
        youtubeView = movie.youtubeView
        if let formatDate = formatDate(dateString: release_date ?? "") {
            self.release_date = formatDate
        }
    }
    
    //MARK: -- Private Methods
    private func formatDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
}

