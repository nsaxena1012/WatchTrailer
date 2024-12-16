//
//  Constant.swift
//  WatchTrailerAPP
//
//  Created by apple on 04/12/24.
//

import Foundation
struct BaseUrl {
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = "154ad8f9017ced85e1b45f006f50d4a0"
    
}
struct EndPoint {
    static let trandingMovieWeek = "/trending/movie/week"
    static let trandingMovieday = "/trending/movie/day"
    static let nowPlayingMovies = "/movie/now_playing"
    static let topRatingMovies = "/movie/top_rated"
    static let upcomingMovies = "/movie/upcoming"
    static let movieDetails = "/movie/{movie_id}"
    static let castDetails = "/movie/{movie_id}/credits"
    static let movieReviews = "/movie/{movie_id}/reviews"
    static let trailer = "/movie/{movie_id}/videos"
        
        // Replace {movie_id} with the actual value
        static func getMovieDetailsURL(with movieID: Int) -> String {
            return movieDetails.replacingOccurrences(of: "{movie_id}", with: "\(movieID)")
        }
    static func getCastDetailsURL(with movieID: Int) -> String {
        return castDetails.replacingOccurrences(of: "{movie_id}", with: "\(movieID)")
    }
    static func movieReviewsURL(with movieID: Int) -> String {
        return movieReviews.replacingOccurrences(of: "{movie_id}", with: "\(movieID)")
    }
    static func trailer(with movieID: Int) -> String {
        return trailer.replacingOccurrences(of: "{movie_id}", with: "\(movieID)")
    }
    
}
//- Endpoint: '/movie/top_rated'
// - Endpoint: '/movie/{movie_id}'
//- Endpoint: '/movie/{movie_id}/credits'
///movie/{movie_id}/reviews
///videos
