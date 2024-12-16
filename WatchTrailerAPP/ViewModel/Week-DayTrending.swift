//
//  Week-DayTrending.swift
//  WatchTrailerAPP
//
//  Created by apple on 09/12/24.
//

import Foundation
class WeakDayTrending {
    var trendingMovies: [TrendingMovie] = []
    func fetchWeekDayTrendingMovies(completion: @escaping (Result<[TrendingMovie], Error>) -> Void) {
        fetchMovieData { result in
            switch result {
            case .success(let movieData):
                self.decodeTrendingMovies(from: movieData, completion: completion)
            case .failure(let error):
                completion(.failure(error)) 
            }
        }
      
    }
    private func fetchMovieData(completion: @escaping (Result<Data, Error>) -> Void) {
        APINetwork.shared.fetchMovies(endPoint: EndPoint.trandingMovieWeek) { result in
            completion(result) // Directly pass the network result
        }
    }
    private func decodeTrendingMovies(from data: Data, completion: @escaping (Result<[TrendingMovie], Error>) -> Void) {
        do {
            let trendingModel = try JSONDecoder().decode(TrendingModel.self, from: data)
            completion(.success(trendingModel.results))
        } catch {
            completion(.failure(error)) // Handle decoding error
        }
    }
    
}
