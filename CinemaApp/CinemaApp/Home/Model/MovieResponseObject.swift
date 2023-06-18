//
//  MovieResponseObject.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import Foundation

struct MovieResponseObject: Codable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}

