//
//  DetailViewcontroller+API's.swift
//  WatchTrailerAPP
//
//  Created by apple on 12/12/24.
//

import Foundation
extension DetailViewController {
    func fetchMovieDetails(movieId: Int) {
            movieDetail.fetchDetailsMovies(movieID: movieId) { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.updateUI(with: data)
                       
                    }
                case .failure(let error):
                    print("Failed to fetch movie details: \(error.localizedDescription)")
                }
            }
        }
    
    func castDetail(movieID : Int) {
        castDetail.castDetailFetch(movieID: movieID) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.castData(with: data)
                   
                }
            case .failure(let error):
                print("Failed to fetch movie details: \(error.localizedDescription)")
            }
            }
        }
    func reviewDetail(movieID:Int) {
        reviewDetails.reviewFetch(movieID: movieID){ result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.reviewData(with: data.results)
                   
                }
            case .failure(let error):
                print("Failed to fetch movie details: \(error.localizedDescription)")
            }
            }
    }
    
    func trailerFetch(movieID :Int) {
        trailerDetails.trailerFetch(movieID: movieID) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.trailers = data.results
                   
                }
            case .failure(let error):
                print("Failed to fetch movie details: \(error.localizedDescription)")
            }
            }
    }
}
