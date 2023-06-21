//
//  VideoResponseModel.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 19/06/2023.
//

import Foundation

struct VideoResponseModel: Codable {
    var id: IdVideo
}

struct IdVideo: Codable {
    let kind: String
    var videoId: String
}
