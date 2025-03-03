//
//  TopRatedCollectionViewCell.swift
//  
//
//  Created by apple on 09/12/24.
//

import UIKit
import SDWebImage
class TopRatedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var topRatedHomeView : UIView!
    @IBOutlet weak var topRatedHomeImage : UIImageView!
    var topRatedMovie : TrendingMovie? {
        didSet {
            guard let movie = topRatedMovie else { return }
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
            topRatedHomeImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        } else {
            print("Invalid URL: \(movie.posterPath ?? "nil")")
            topRatedHomeImage.image = UIImage(named: "placeholder") ?? UIImage()
        }
    }

}
