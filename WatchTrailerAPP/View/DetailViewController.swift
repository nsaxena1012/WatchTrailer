//
//  DetailViewController.swift
//  WatchTrailerAPP
//
//  Created by apple on 12/12/24.
//

import UIKit
import SDWebImage
import YouTubeiOSPlayerHelper

class DetailViewController: UIViewController {
    @IBOutlet var posterPathImage: UIImageView!
    @IBOutlet weak var movieTitle : UILabel!
    @IBOutlet weak var releaseDate : UILabel!
    @IBOutlet weak var runtime : UILabel!
    @IBOutlet weak var castLabel : UILabel!
    @IBOutlet var overviewTextView: UITextView!
    @IBOutlet var reviewDetailsTextView: UITextView!
    @IBOutlet weak var imdbRating : UILabel!
    @IBOutlet weak var moreButton: UIButton!
  
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var authorName: UILabel!
    var targetFrame: CGRect?
    var movieDetail = MovieDetailsModel()
    var castDetail = MovieDetailsModel()
    var reviewDetails = MovieDetailsModel()
    var trailerDetails = MovieDetailsModel()
    var movieID : Int?
    var castmovieTitle : String?
    var allCastNames: [String] = []
    var generes : [String] = []
    var castNamesToShow: [String] = []
    var castData : CastResponse?
    var trailers: [Trailer] = []
    var movieDetails : MovieDetailedModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movieID = movieID else {
            // Show error or handle nil case
            return
        }
        loadAllData(movieId: movieID)
       
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
           
    }
    
    
    
    @IBAction func crossButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func castData(with data: CastResponse) {
        allCastNames = data.cast.map { $0.name }

        // Define a limit for the number of cast names to show initially
        let castLimit = 3
        castNamesToShow = Array(allCastNames.prefix(castLimit))

        // Set the cast label text with the cast names up to the limit
        castLabel.text = castNamesToShow.joined(separator: ", ")
        
        // Show the "More" button only if the number of cast names exceeds the limit
        if allCastNames.count > castLimit {
            moreButton.isHidden = false
            moreButton.setTitle("...More", for: .normal)
        } else {
            moreButton.isHidden = true
        }

        // Adjust the layout of the cast label dynamically
       
    }
    func reviewData(with data: [ReviewResult]) {
        authorName.text = "A review by \(data.first?.author ?? "")"
        reviewDetailsTextView.text = data.first?.content
        DispatchQueue.main.async {
            if let rating = data.first?.authorDetails.rating {
                self.imdbRating.text = String(format: "IMDB RATING %.1f/10", Double(rating))
            } else {
                self.imdbRating.text = "IMDB RATING N/A/10"
            }
        }
       // dateLabel.text = "Written by CinemaSerf on \(data.first?.createdAt ?? "")"
        if let createdAtString = data.first?.createdAt {
            // Print the string to check its format
            print("createdAt: \(createdAtString)")
            
            // Parse the string into a Date
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Adjusted format to match "2024-11-10T06:23:14.120Z"
            
            if let createdAtDate = inputFormatter.date(from: createdAtString) {
                // If the string is successfully parsed into a Date
                let formattedDate = getFormattedDate(date: createdAtDate)
                dateLabel.text = "Written by CinemaSerf on \(formattedDate)"
            } else {
                // If the date could not be parsed
                dateLabel.text = "Written by CinemaSerf on Unknown Date"
            }
        } else {
            dateLabel.text = "Written by CinemaSerf on Unknown Date"
        }
    }

   
    @objc func moreButtonTapped() {
           let castVC = storyboard?.instantiateViewController(withIdentifier: "CastViewController") as! CastViewController
        castVC.castNames = allCastNames
        castVC.genres = generes
        castVC.movieCastTitle = castmovieTitle
        castVC.sheetPresentationController?.detents  = [.medium()]
        self.present(castVC, animated: true)  // Push to the new view controller
       }
    
    @IBAction func playtrailertapped(_ sender: UIButton) {
        let video = storyboard?.instantiateViewController(identifier: "TrailerViewController") as! TrailerViewController
        video.trailers = trailers
        self.present(video, animated: true)
     
    }
}

extension DetailViewController {
    func getFormattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy" // Full month name, day, and year
        return dateFormatter.string(from: date)
    }
    
 
}

