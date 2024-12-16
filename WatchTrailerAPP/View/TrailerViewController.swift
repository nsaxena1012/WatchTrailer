//
//  TrailerViewController.swift
//  
//
//  Created by apple on 12/12/24.
//

import UIKit
import YouTubeiOSPlayerHelper
class TrailerViewController: UIViewController,YTPlayerViewDelegate {
    @IBOutlet var playerView: YTPlayerView!
    var trailers: [Trailer] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       // playVideo()
        playerView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playVideo()
    }
   
    func playVideo(){
        if let firstTrailer = trailers.first {
            // Retrieve the trailer key from the first trailer in the list
            let trailerKey = firstTrailer.key
            playerView.load(withVideoId: trailerKey)
            DispatchQueue.main.async {
                self.playerView.playVideo()
            }
           
            // Construct the YouTube video URL using the trailer key
        }
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo() // Play video once it's ready
    }
}
