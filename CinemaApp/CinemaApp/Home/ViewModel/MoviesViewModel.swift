//
//  MoviesViewModel.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import Foundation

protocol MoviesViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var numberOfCells: Int { get }
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((Int) -> Void)? { get set }
    var selectedMovies: [MovieCellViewModel] { get set }
    
    func getMovie(for row: Int) -> MovieCellViewModel
}

final class MoviesViewModel: MoviesViewModelProtocol {
    //MARK: -- Properties
    var selectedMovies: [MovieCellViewModel] = [] {
        didSet {
            saveSelectedMovies()
        }
    }
    var reloadCell: ((Int) -> Void)?
    var showError: ((String) -> Void)?
    var reloadData: (() -> Void)?
    
    private var movies: [MovieCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    private var video: VideoResponseModel?
    var numberOfCells: Int {
        return movies.count
    }
    
    //MARK: -- Initialization
    init() {
        loadData()
    }
    
    //MARK: -- Methods
    func getMovie(for row: Int) -> MovieCellViewModel {
        let movie = movies[row]
        return movie
    }
    
    //MARK: -- Private Methods
    private func saveSelectedMovies() {
        guard let data = try? JSONEncoder().encode(selectedMovies) else {
            return
        }
        UserDefaults.standard.setValue(data, forKey: "movies")
    }
    
    private func loadData() {
        APIManager.fetchMovies() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.movies = self.convertToCellViewModel(movies)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func convertToCellViewModel(_ movies: [Movie]) -> [MovieCellViewModel] {
        return movies.map { MovieCellViewModel(movie: $0) }
    }
    
    private func setupMockObjects() {
        movies = [
            MovieCellViewModel(movie: Movie(adult: true, id: 18, posterPath: "", title: "First Movie",
                                            voteAverage: 5,
                                            overview: "Hello, I am first description",
                                            voteCount: 5, releaseDate: "2012", originalName: "")),
            MovieCellViewModel(movie: Movie(adult: true, id: 19, posterPath: "", title: "Second Movie",
                                            voteAverage: 5,
                                            overview: "Hello, I am second description",
                                            voteCount: 5, releaseDate: "2005", originalName: ""))
        ]
    }
}
