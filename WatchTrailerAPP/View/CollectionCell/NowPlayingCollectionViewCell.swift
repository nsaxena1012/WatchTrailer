//
//  NowPlayingCollectionViewCell.swift
//  WatchTrailerAPP
//
//  Created by apple on 09/12/24.
//

import UIKit
import SDWebImage

class NowPlayingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nowPlayingHomeView : UIView!
    @IBOutlet weak var nowPlayingHomeImage : UIImageView!
    var nowPlayingMovie : TrendingMovie? {
        didSet {
            guard let movie = nowPlayingMovie else { return }
                updateUI(movie: movie)
            setUI()
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func setUI() {
        nowPlayingHomeView.layer.cornerRadius = 10
        nowPlayingHomeView.layer.shadowColor = UIColor.white.cgColor
        nowPlayingHomeView.layer.shadowOpacity = 0.5
        nowPlayingHomeView.layer.shadowOffset = .zero
    }
    private func updateUI(movie: TrendingMovie) {
        // Replace this with your actual base URL
        let baseURL = "https://image.tmdb.org/t/p/w500"
        
        // Combine the base URL with the posterPath
        if let posterPath = movie.posterPath,
           let imageUrl = URL(string: baseURL + posterPath) {
            nowPlayingHomeImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        } else {
            print("Invalid URL: \(movie.posterPath ?? "nil")")
            nowPlayingHomeImage.image = UIImage(named: "placeholder") ?? UIImage()
        }
    }

}
