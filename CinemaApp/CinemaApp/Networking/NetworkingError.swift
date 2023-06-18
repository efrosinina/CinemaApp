//
//  NetworkingError.swift
//  CinemaApp
//
//  Created by Елизавета Ефросинина on 18/06/2023.
//

import UIKit

enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknown
}

