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
        
        // Determine the movie ID based on which collection view is selected
        var movieID: Int = 0
        if collectionView == trendingCollectionView {
            movieID = viewModel.trendingMovies[indexPath.row].id
        } else if collectionView == nowPlayingCollectionView {
            movieID = nowPlayingViewModel.nowPlayingMovies[indexPath.row].id
        } else if collectionView == topRatedCollectionView {
            movieID = topRatedviewModel.topRatedMovies[indexPath.row].id
        } else if collectionView == upcomingCollectionView {
            movieID = upcomingViewModel.upcomingMovies[indexPath.row].id
        }
        
        // Prepare the destination view controller
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.transitioningDelegate = self
        detailVC.movieID = movieID
        detailVC.modalPresentationStyle = .overFullScreen
        
        // 5. Animate the snapshot to expand and cover the screen
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
            snapshot.frame = self.view.bounds
            snapshot.layer.cornerRadius = 10
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
            if collectionView == trendingCollectionView {
                let height = collectionView.frame.height  // Make the cell height fit the collection view's height
                let width = height * 0.7
                // Adjust the width-to-height ratio as needed
                return CGSize(width: width, height: height)
                
                
            }else{
                let collectionViewWidth = collectionView.frame.width
                let collectionViewHeight = collectionView.frame.height
                
                // Horizontal settings
                let spacing: CGFloat = 10
                let numberOfColumns: CGFloat = 3
                let sectionInsets: CGFloat = 10 * 2 // Left and Right Insets
                
                // Vertical settings
                let topInset: CGFloat = 10
                let bottomInset: CGFloat = 10
                let verticalSpacing: CGFloat = 10
                
                // Calculate usable width
                let usableWidth = collectionViewWidth - sectionInsets - (spacing * (numberOfColumns - 1))
                let cellWidth = usableWidth / numberOfColumns
                
                // Calculate usable height
                let totalVerticalSpacing = topInset + bottomInset + verticalSpacing
                let usableHeight = collectionViewHeight - totalVerticalSpacing
                let cellHeight = usableHeight // Or use ratio (cellWidth * 1.5) if needed
                
                return CGSize(width: cellWidth, height: cellHeight)
            }
            
            
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            // Set insets to zero to remove spacing around the collection view content
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            // Set the space between items horizontally (reduce the space)
            return 10 // This removes horizontal spacing
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            // Set the space between items vertically (reduce the space)
            return 10  // This removes vertical spacing
        }
        
    }
extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransition()
    }
}
