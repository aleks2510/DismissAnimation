//
//  DismissAnimator.swift
//  DismissAnimation
//
//  Created by alejandro Lopez on 12/22/16.
//  Copyright © 2016 Alejandro Lopez. All rights reserved.
//

import UIKit

class DismissAnimator: NSObject {
    
    var destinationFrame = CGRect.zero
}

/*
 The animator adopts the UIViewControllerAnimatedTransitioning Protocol which has two required methiods:
 transitionDuration(_:)
 animationTransition(_:)
 */

extension DismissAnimator : UIViewControllerAnimatedTransitioning {
    

    
    //MARK: transitionDuration(_:): This is how long the animation is
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    //MARK: animationTransition(_:): This is the animation and the code will go here.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        let containerView = transitionContext.containerView
       
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
    
        
        let screenBounds = UIScreen.main.bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: (screenBounds.size ))
        
        /*
         The animation will place the view into the finalFrame position
         */
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromViewController.view.layer.opacity = 0.0
                fromViewController.view.frame = finalFrame
        },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        )
        
        
        
        
    }
}
