//
//  MovieDetailsModel.swift
//  WatchTrailerAPP
//
//  Created by apple on 12/12/24.
//

import Foundation
class MovieDetailsModel {
    var movieDetails : MovieDetailedModel?
    var castDetails : CastResponse?
    var reviewDetails : ReviewsDetailModel?
    var trailerDetails : TrailerResponse?
    
    func fetchDetailsMovies(movieID : Int, completion: @escaping (Result<MovieDetailedModel, Error>) -> Void) {
        fetchMovieData(movieId: movieID) { result in
            switch result {
            case .success(let movieData):
                self.decodeDetailsMovies(from: movieData, completion: completion)
            case .failure(let error):
                completion(.failure(error)) // Pass the error directly
            }
        }
    }
    // Function 1: Fetch movie data (handles API calls)
    private func fetchMovieData(movieId : Int, completion: @escaping (Result<Data, Error>) -> Void) {
        APINetwork.shared.fetchMovies(endPoint: EndPoint.getMovieDetailsURL(with: movieId)) { result in
            completion(result) // Directly pass the network result
        }
    }
    // Function 2: Decode movie data (handles JSON decoding)
    private func decodeDetailsMovies(from data: Data, completion: @escaping (Result<MovieDetailedModel, Error>) -> Void) {
        do {
            let detailsModel = try JSONDecoder().decode(MovieDetailedModel.self, from: data)
            completion(.success(detailsModel))
        } catch {
            completion(.failure(error)) // Handle decoding error
        }
    }
    
    func castDetailFetch(movieID : Int,completion: @escaping (Result<CastResponse, Error>) -> Void) {
        APINetwork.shared.fetchMovies(endPoint: EndPoint.getCastDetailsURL(with: movieID)) { result in
            switch result {
            case .success(let data):
                do{
                    let decodedData = try JSONDecoder().decode(CastResponse.self, from: data)
                    completion(.success(decodedData))
                }catch{
                    completion(.failure(error))
                }
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    func reviewFetch(movieID : Int,completion: @escaping (Result<ReviewsDetailModel, Error>) -> Void) {
        APINetwork.shared.fetchMovies(endPoint: EndPoint.movieReviewsURL(with: movieID)) { result in
            switch result {
            case .success(let data):
                do{
                    let decodedData = try JSONDecoder().decode(ReviewsDetailModel.self, from: data)
                    completion(.success(decodedData))
                }catch{
                    completion(.failure(error))
                }
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    func trailerFetch(movieID : Int,completion: @escaping (Result<TrailerResponse, Error>) -> Void) {
        APINetwork.shared.fetchMovies(endPoint: EndPoint.trailer(with: movieID)) { result in
            switch result {
            case .success(let data):
                do{
                    let decodedData = try JSONDecoder().decode(TrailerResponse.self, from: data)
                    completion(.success(decodedData))
                }catch{
                    completion(.failure(error))
                }
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}


