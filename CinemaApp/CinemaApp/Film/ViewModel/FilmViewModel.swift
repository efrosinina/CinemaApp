//
//  FilmViewModel.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 19/06/2023.
//

import UIKit
import WebKit

protocol FilmViewModelProtocol {
    var title: String? { get }
    var poster_path: String? { get }
    var overview: String? { get }
    var vote_average: Double { get }
    var release_date: String? { get }
    var original_name: String? { get }
    var youtubeView: VideoResponseModel? { get set }
    
    func loadData(wkView: WKWebView)
}

final class FilmViewModel: FilmViewModelProtocol {
    var youtubeView: VideoResponseModel?
    let title: String?
    let poster_path: String?
    let overview: String?
    let vote_average: Double
    let release_date: String?
    let original_name: String?
    
    func loadData(wkView: WKWebView) {
        APIManager.getYoutubeTrailer(with: (title ?? "") + " trailer") { result in
            switch result {
            case .success(let video):
                self.youtubeView = video
                guard let youtubeUrl = URL(string: "https://www.youtube.com/embed/\(video.id.videoId)") else { return }
                DispatchQueue.main.async {
                    wkView.load(URLRequest(url: youtubeUrl))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    init(movie: MovieCellViewModel) {
        title = movie.title
        poster_path = movie.poster_path
        overview = movie.overview
        vote_average = movie.vote_average ?? 9.0
        release_date = movie.release_date
        original_name = movie.original_name
    }
}
