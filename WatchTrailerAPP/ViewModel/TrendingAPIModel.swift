//
//  TrendingAPIModel.swift
//  WatchTrailerAPP
//
//  Created by apple on 04/12/24.
//

import Foundation
class TrendingAPIModel {
    var trendingMovies: [TrendingMovie] = []
    /*
     Using Solid Principle Step 1:- Single Responsibility Principle (SRP)
     */
    func fetchTrendingMovies(completion: @escaping (Result<[TrendingMovie], Error>) -> Void) {
        fetchMovieData { result in
            switch result {
            case .success(let movieData):
                self.decodeTrendingMovies(from: movieData, completion: completion)
            case .failure(let error):
                completion(.failure(error)) // Pass the error directly
            }
        }
    }
    // Function 1: Fetch movie data (handles API calls)
    private func fetchMovieData(completion: @escaping (Result<Data, Error>) -> Void) {
        APINetwork.shared.fetchMovies(endPoint: EndPoint.trandingMovieday) { result in
            completion(result) // Directly pass the network result
        }
    }
    // Function 2: Decode movie data (handles JSON decoding)
    private func decodeTrendingMovies(from data: Data, completion: @escaping (Result<[TrendingMovie], Error>) -> Void) {
        do {
            let trendingModel = try JSONDecoder().decode(TrendingModel.self, from: data)
            completion(.success(trendingModel.results))
        } catch {
            completion(.failure(error)) // Handle decoding error
        }
    }
    
}
