//
//  HomeViewController + API's.swift
//  WatchTrailerAPP
//
//  Created by apple on 09/12/24.
//

import Foundation
extension HomeViewController {
    func fetchTrendingData(completion: @escaping () -> Void){
        viewModel.fetchTrendingMovies { [weak self] result in
            switch result {
            case .success(let data):
                self?.viewModel.trendingMovies = data
                print(data)
                DispatchQueue.main.async {
                    completion() // Call completion when done
                }
                
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    completion() // Call completion when done
                }
            }
        }
    }
    func fetchNowPlayingData(completion: @escaping () -> Void){
        nowPlayingViewModel.fetchNowplayingMovies { [weak self] result in
            switch result {
            case .success(let data):
                self?.nowPlayingViewModel.nowPlayingMovies = data
                DispatchQueue.main.async {
                    completion() // Call completion when done
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    completion() // Call completion when done
                }
            }
        }
    }
    func topRatedMovies(completion: @escaping () -> Void){
        topRatedviewModel.fetchPopularplayingMovies{ [weak self] result in
            switch result {
            case .success(let data):
                self?.topRatedviewModel.topRatedMovies = data
                DispatchQueue.main.async {
                    completion() // Call completion when done
                }
                
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    completion() // Call completion when done
                }
            }
        }
    }
    
    func upcomingMovies(completion: @escaping () -> Void){
        upcomingViewModel.fetchUpcomingMovies{ [weak self] result in
            switch result {
            case .success(let data):
                self?.upcomingViewModel.upcomingMovies = data
                DispatchQueue.main.async {
                    completion() // Call completion when done
                }
                
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    completion() // Call completion when done
                }
            }
        }
    }
}
