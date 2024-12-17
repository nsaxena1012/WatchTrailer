//
//  ViewController.swift
//  WatchTrailerAPP
//
//  Created by apple on 04/12/24.
//

import UIKit
//import DropDown

class HomeViewController: UIViewController {
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    var viewModel = TrendingAPIModel()
    var weekViewModel = WeakDayTrending()
    var nowPlayingViewModel = NowPlayingModel()
    var topRatedviewModel = TopRatedMovieModel()
    var upcomingViewModel = UpcomingMoviesModel()
    var trendingArray : [TrendingMovie] = []
    var nowPlayingArray : [TrendingMovie] = []
    var topRated : [TrendingMovie] = []
    var upcomingMoives : [TrendingMovie] = []
    var timer: Timer?
    var currentIndex = 0
    var movieID: Int = 0
    // let dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerCell()
        fetchAPI()
        startAutoScroll()
        print(nowPlayingCollectionView.frame.width)
        print(nowPlayingCollectionView.frame.height)
    }
    
    func fetchAPI() {
        let dispatchGroup = DispatchGroup()
            
            // Call fetchTrendingData
            dispatchGroup.enter()
            fetchTrendingData {
                dispatchGroup.leave()
            }
            
            // Call fetchNowPlayingData
            dispatchGroup.enter()
            fetchNowPlayingData {
                dispatchGroup.leave()
            }
            
            // Call topRatedMovies
            dispatchGroup.enter()
            topRatedMovies {
                dispatchGroup.leave()
            }
            
            // Call upcomingMovies
            dispatchGroup.enter()
            upcomingMovies {
                dispatchGroup.leave()
            }
            
            // When all API calls have completed, reload the collection views
            dispatchGroup.notify(queue: .main) {
                self.trendingCollectionView.reloadData()
                self.nowPlayingCollectionView.reloadData()
                self.topRatedCollectionView.reloadData()
                self.upcomingCollectionView.reloadData()
            }
        }
    
    func setUI(){
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        topRatedCollectionView.delegate = self
        topRatedCollectionView.dataSource = self
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
    }
    func registerCell(){
        let cellNib = UINib(nibName: "TrendingCollectionViewCell", bundle: nil)
        trendingCollectionView.register(cellNib, forCellWithReuseIdentifier: "TrendingCollectionViewCell")
        nowPlayingCollectionView.register(UINib(nibName: "NowPlayingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NowPlayingCollectionViewCell")
        topRatedCollectionView.register(UINib(nibName: "TopRatedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedCollectionViewCell")
        upcomingCollectionView.register(UINib(nibName: "UpcomingMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingMoviesCollectionViewCell")
    }
    func startAutoScroll() {
            // Create a repeating timer to scroll every 3 seconds
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(moveToNextItem), userInfo: nil, repeats: true)
        }

    
    @objc func moveToNextItem() {
           // Ensure the array isn't empty
           let totalItems = trendingCollectionView.numberOfItems(inSection: 0)
           if totalItems == 0 { return }
           
           currentIndex += 1
           if currentIndex >= totalItems {
               currentIndex = 0 // Reset to the first index when reaching the end
           }
           
           // Scroll to the next item with animation
           trendingCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
       }
    
    func stopAutoScroll() {
            timer?.invalidate()
            timer = nil
        }
        
        // MARK: - Clean Up
        deinit {
            stopAutoScroll()
        }
    
    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            weekViewModel.fetchWeekDayTrendingMovies { result in
                switch result {
                case .success(let data):
                    self.viewModel.trendingMovies = data
                    self.currentIndex = 0
                    DispatchQueue.main.async {
                        self.trendingCollectionView.reloadData()
                    }
                  
                case .failure(let error):
                    print(error)
                }
            }
        }else if sender.selectedSegmentIndex == 0 {
            viewModel.fetchTrendingMovies { result in
                switch result {
                case .success(let data):
                    self.viewModel.trendingMovies = data
                    self.currentIndex = 0
                    DispatchQueue.main.async {
                        self.trendingCollectionView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
                }
               
                
            }
        }
    }
}

