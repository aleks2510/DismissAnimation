//
//  SecondView.swift
//  DismissAnimation
//
//  Created by alejandro Lopez on 12/22/16.
//  Copyright © 2016 alejandro Lopez. All rights reserved.
//

import UIKit

class SecondView: UIViewController {

    var interactor : Interactor? = nil
    
    @IBAction func CancelButtonDidTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        let percentThreshold:CGFloat = 0.3
        
        //Convert y-positionto downward pull progress(percentage)
        
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmax(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fmin(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }
        
        
    }
}
