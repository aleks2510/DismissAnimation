//
//  ViewController.swift
//  DismissAnimation
//
//  Created by Alejandro Lopez on 12/22/16.
//  Copyright © 2016 Alejandro Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let interactor = Interactor()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SecondView {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactor = interactor // new
        }
    }
    
    @IBAction func unwindToMain(_ segue: UIStoryboardSegue) {
        loadView()
    }

}

extension ViewController : UIViewControllerTransitioningDelegate {
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
}

