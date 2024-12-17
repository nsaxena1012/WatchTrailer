//
//  customAnimation.swift
//  WatchTrailerAPP
//
//  Created by apple on 17/12/24.
//

import Foundation
import UIKit
class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7 // Duration of the transition
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
            return
        }

        // Add toView (destination) to the container view
        containerView.addSubview(toView)

        // Set initial position of the destination view off-screen
        toView.frame = containerView.bounds
        toView.alpha = 0

        // Add snapshot animation
        UIView.animate(withDuration: 0.7, animations: {
            fromView.alpha = 0
            toView.alpha = 1
        }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }
}
