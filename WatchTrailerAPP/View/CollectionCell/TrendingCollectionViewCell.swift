//
//  HomeCollectionViewCell.swift
//  WatchTrailerAPP
//
//  Created by apple on 04/12/24.
//

import UIKit
import SDWebImage

class TrendingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var homeView : UIView!
    @IBOutlet weak var homeImage : UIImageView!
    var trendingMovies : TrendingMovie?{
        didSet{
            // Update UI when `trendingMovies` is set using Property Observer DidSet
        guard let movie = trendingMovies else { return }
            updateUI(movie: movie)
            setUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUI(){
//        homeView.layer.cornerRadius = 10
//        homeView.layer.shadowColor = UIColor.white.cgColor
//        homeView.layer.shadowOpacity = 0.5
//        homeView.layer.shadowOffset = .zero
    }
    private func updateUI(movie: TrendingMovie) {
        // Replace this with your actual base URL
        let baseURL = "https://image.tmdb.org/t/p/w500"
        
        // Combine the base URL with the posterPath
        if let posterPath = movie.posterPath,
           let imageUrl = URL(string: baseURL + posterPath) {
            homeImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        } else {
            print("Invalid URL: \(movie.posterPath ?? "nil")")
            homeImage.image = UIImage(named: "placeholder") ?? UIImage()
        }
    }

    
}
