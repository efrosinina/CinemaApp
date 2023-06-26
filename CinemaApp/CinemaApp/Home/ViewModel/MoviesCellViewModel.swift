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
    let originalName: String?
    let posterPath: String?
    let overview: String?
    let voteAverage: Double?
    let voteCount: Int
    var releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalName = "original_name"
        case posterPath = "poster_path"
        case overview
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
    }
    
    //MARK: -- Initialization
    init(movie: Movie) {
        overview = movie.overview
        voteAverage = movie.voteAverage
        title = movie.title
        posterPath = movie.posterPath
        voteCount = movie.voteCount
        releaseDate = movie.releaseDate
        id = movie.id
        originalName = movie.originalName
        if let formatDate = formatDate(dateString: releaseDate ?? "") {
            self.releaseDate = formatDate
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
