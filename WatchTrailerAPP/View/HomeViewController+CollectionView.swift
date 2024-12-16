//
//  HomeViewController+CollectionView.swift
//  WatchTrailerAPP
//
//  Created by apple on 04/12/24.
//

import Foundation
import UIKit
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.trendingMovies.count
            
        case 1 :
            return nowPlayingViewModel.nowPlayingMovies.count
        case 2:
            return topRatedviewModel.topRatedMovies.count
        case 3:
            return upcomingViewModel.upcomingMovies.count
        default:
            return 0
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case trendingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath) as! TrendingCollectionViewCell
            let movie = viewModel.trendingMovies[indexPath.row]
            cell.trendingMovies = movie
            return cell
            
        case nowPlayingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCollectionViewCell", for: indexPath) as! NowPlayingCollectionViewCell
            let movie = nowPlayingViewModel.nowPlayingMovies[indexPath.row]
            cell.nowPlayingMovie = movie
            return cell
            
        case topRatedCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCollectionViewCell", for: indexPath) as! TopRatedCollectionViewCell
            let movie = topRatedviewModel.topRatedMovies[indexPath.row]
            cell.topRatedMovie = movie
            return cell
            
        case upcomingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingMoviesCollectionViewCell", for: indexPath) as! UpcomingMoviesCollectionViewCell
            let movie = upcomingViewModel.upcomingMovies[indexPath.row]
            cell.upcomingMovies = movie
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Get the selected cell and its snapshot
        guard let selectedCell = collectionView.cellForItem(at: indexPath) else { return }
        guard let snapshot = selectedCell.snapshotView(afterScreenUpdates: true) else { return }
        
        // 2. Get the starting frame of the cell relative to the main view
        let startingFrame = selectedCell.convert(selectedCell.bounds, to: self.view)
        snapshot.frame = startingFrame
        
        // 3. Add the snapshot to the main view
        self.view.addSubview(snapshot)
        selectedCell.isHidden = true
        
         let movie = upcomingViewModel.upcomingMovies[indexPath.row]
        if collectionView == trendingCollectionView {
                let movie = viewModel.trendingMovies[indexPath.row]
                movieID = movie.id
            } else if collectionView == nowPlayingCollectionView {
                let movie = nowPlayingViewModel.nowPlayingMovies[indexPath.row]
                movieID = movie.id
            } else if collectionView == topRatedCollectionView {
                let movie = topRatedviewModel.topRatedMovies[indexPath.row]
                movieID = movie.id
            } else if collectionView == upcomingCollectionView {
                let movie = upcomingViewModel.upcomingMovies[indexPath.row]
                movieID = movie.id
            }
        
        // Prepare the destination view controller
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.movieID = movieID
        //        let detailVC = DetailViewController()
        //           detailVC.modalPresentationStyle = .overFullScreen
        
        // 5. Animate the snapshot to expand and cover the screen
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
            snapshot.frame = self.view.bounds
            snapshot.layer.cornerRadius = 10
          //  snapshot.clipsToBounds = true
        }) { completed in
            if completed {
                // 6. Present the detail view controller after the animation completes
                self.present(detailVC, animated: false) {
                    // 7. Clean up the snapshot and unhide the cell
                    snapshot.removeFromSuperview()
                    selectedCell.isHidden = false
                }
            }
        }
       }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height  // Make the cell height fit the collection view's height
        let width = height * 0.7
        // Adjust the width-to-height ratio as needed
                return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Set insets to zero to remove spacing around the collection view content
        return UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // Set the space between items horizontally (reduce the space)
        return 20 // This removes horizontal spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Set the space between items vertically (reduce the space)
        return 20  // This removes vertical spacing
    }
   
}
