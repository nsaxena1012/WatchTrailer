//
//  UpcomingMoviesCollectionViewCell.swift
//  WatchTrailerAPP
//
//  Created by apple on 09/12/24.
//

import UIKit

class UpcomingMoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet var upcomingHomeVie: UIView!
    
    @IBOutlet var upcomingHomeImage: UIImageView!
    var upcomingMovies : TrendingMovie?{
        didSet{
            // Update UI when `trendingMovies` is set using Property Observer DidSet
        guard let movie = upcomingMovies else { return }
            updateUI(movie: movie)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    private func updateUI(movie: TrendingMovie) {
        // Replace this with your actual base URL
        let baseURL = "https://image.tmdb.org/t/p/w500"
        
        // Combine the base URL with the posterPath
        if let posterPath = movie.posterPath,
           let imageUrl = URL(string: baseURL + posterPath) {
            upcomingHomeImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        } else {
            print("Invalid URL: \(movie.posterPath ?? "nil")")
            upcomingHomeImage.image = UIImage(named: "placeholder") ?? UIImage()
        }
    }
}
