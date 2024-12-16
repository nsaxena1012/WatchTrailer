//
//  MovieDetail.swift
//  WatchTrailerAPP
//
//  Created by apple on 12/12/24.
//

import Foundation
struct MovieDetailedModel: Codable {
    let title: String
    let overview: String
    let genres: [Genre]
    let releaseDate: String
    let runtime: Int
    let posterPath: String?
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case title, overview, genres
        case releaseDate = "release_date"
        case runtime
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

struct Genre: Codable {
    let name: String
}

struct CastResponse: Codable {
    let cast: [CastMember]
}

struct CastMember: Codable {
    let name: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
    }
}
