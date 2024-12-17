import Foundation
import UIKit
extension DetailViewController {
    func loadAllData(movieId: Int) {
        // Create a DispatchGroup to synchronize concurrent tasks
        let dispatchGroup = DispatchGroup()
        
        // Begin the first API call and add it to the dispatch group
        dispatchGroup.enter()
        fetchMovieDetails(movieId: movieId) {
            dispatchGroup.leave() // Call leave when the request finishes
        }
        
        // Begin the second API call and add it to the dispatch group
        dispatchGroup.enter()
        castDetail(movieId: movieId) {
            dispatchGroup.leave() // Call leave when the request finishes
        }
        
        // Begin the third API call and add it to the dispatch group
        dispatchGroup.enter()
        reviewDetail(movieId: movieId) {
            dispatchGroup.leave() // Call leave when the request finishes
        }
        
        // Begin the fourth API call and add it to the dispatch group
        dispatchGroup.enter()
        trailerFetch(movieId: movieId) {
            dispatchGroup.leave() // Call leave when the request finishes
        }
        dispatchGroup.notify(queue: .main) {
            UIView.animate(withDuration: 0.9) {
                self.updateUIWithFetchedData()
            }
            
        }
        // When all the API calls have finished, update the UI
        
    }
    
    func fetchMovieDetails(movieId: Int, completion: @escaping () -> Void) {
        movieDetail.fetchDetailsMovies(movieID: movieId) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.movieDetails = data
                    // self?.updateUI(with: data)
                }
            case .failure(let error):
                print("Failed to fetch movie details: \(error.localizedDescription)")
            }
            completion() // Call completion after the task finishes
        }
    }
    
    func castDetail(movieId: Int, completion: @escaping () -> Void) {
        castDetail.castDetailFetch(movieID: movieId) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.castData(with: data)
                }
            case .failure(let error):
                print("Failed to fetch cast details: \(error.localizedDescription)")
            }
            completion() // Call completion after the task finishes
        }
    }
    
    func reviewDetail(movieId: Int, completion: @escaping () -> Void) {
        reviewDetails.reviewFetch(movieID: movieId) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.reviewData(with: data.results)
                }
            case .failure(let error):
                print("Failed to fetch review details: \(error.localizedDescription)")
            }
            completion() // Call completion after the task finishes
        }
    }
    
    func trailerFetch(movieId: Int, completion: @escaping () -> Void) {
        trailerDetails.trailerFetch(movieID: movieId) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.trailers = data.results
                }
            case .failure(let error):
                print("Failed to fetch trailer details: \(error.localizedDescription)")
            }
            completion() // Call completion after the task finishes
        }
    }
    
    func updateUIWithFetchedData() {
        if let movieDetails = movieDetails {
            castmovieTitle = movieDetails.title
            movieTitle.text = movieDetails.title
            releaseDate.text = "Release Date: \(movieDetails.releaseDate )"
            runtime.text = "Runtime: \(movieDetails.runtime ) minutes"
            overviewTextView.text = movieDetails.overview
            generes = movieDetails.genres.map{ $0.name }
            UIView.animate(withDuration: 0.9) {
                let baseURL = "https://image.tmdb.org/t/p/w500"
                if let posterPath = movieDetails.backdropPath,
                   let imageUrl = URL(string: baseURL + posterPath) {
                    self.posterPathImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
                } else {
                    print("Invalid URL: \(movieDetails.backdropPath ?? "nil")")
                    self.posterPathImage.image = UIImage(named: "placeholder") ?? UIImage()
                }
            }
            
        } else {
            print("Movie details not available")
            // Handle error, maybe show a placeholder or an error message
        }
        
        
        
    }
    
}
