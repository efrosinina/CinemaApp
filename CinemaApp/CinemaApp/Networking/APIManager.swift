//
//  APIManager.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import Foundation

final class APIManager {
    //MARK: -- API for Movie's Topic
    //MARK: -- Properties
    private static let apiKey = "879df0290516fda72efd515b77289405"
    private static let baseUrl = "https://api.themoviedb.org/3"
    private static let youtubeApiKey = "AIzaSyC5FKMLOt7PpO_-Fi5722P-6WfeWVjkTyM"
    private static let youtubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
    
    //MARK: -- Function
    static func fetchMovies(/*from endpoint: TitleSections, */completion: @escaping (Result<[Movie], Error>) -> ()) {
        let stringUrl = "\(baseUrl)" + "/trending/all/day"/*+ "/movie/day"*//* "\(endpoint.rawValue)"*/+ "?api_key=\(apiKey)"
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            handleResponse(data: data,
                           error: error,
                           completion: completion)
        }
        session.resume()
    }
    
    
    
    static func handleResponse(data: Data?,
                               error: Error?,
                               completion: @escaping (Result<[Movie], Error>) -> ()) {
        if let error = error {
            completion(.failure(error))
        } else if let data = data {
            do {
                let model = try JSONDecoder().decode(MovieResponseObject.self,
                                                     from: data)
                completion(.success(model.results))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
    
    static func getYoutubeTrailer(with query: String, completion: @escaping (Result<VideoResponseModel, Error>) -> ()) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        let stringUrl = "\(youtubeBaseUrl)q=\(query)&key=\(youtubeApiKey)"
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let results = try JSONDecoder().decode(YouTubeSearchResponse.self, from: data)
                    completion(.success(results.items[0]))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        session.resume()
    }
}


