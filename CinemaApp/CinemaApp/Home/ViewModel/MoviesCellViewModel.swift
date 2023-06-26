//
//  MoviesCellViewModel.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import Foundation

struct MovieCellViewModel: Codable {
    //MARK: -- Properties
    let id: Int?
    let title: String?
    let original_name: String?
    let poster_path: String?
    let overview: String?
    let vote_average: Double?
    let vote_count: Int
    var release_date: String?
    
    //MARK: -- Initialization
    init(movie: Movie) {
        overview = movie.overview
        vote_average = movie.voteAverage
        title = movie.title
        poster_path = movie.posterPath
        vote_count = movie.voteCount
        release_date = movie.releaseDate
        id = movie.id
        original_name = movie.originalName
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
