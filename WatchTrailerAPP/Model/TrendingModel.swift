//
//  TrendingModel.swift
//  WatchTrailerAPP
//
//  Created by apple on 04/12/24.
//

import Foundation
struct TrendingModel : Codable {
    let results: [TrendingMovie]
}
struct TrendingMovie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}


