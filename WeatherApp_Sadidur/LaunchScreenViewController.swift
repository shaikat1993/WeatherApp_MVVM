//
//  LaunchScreenViewController.swift
//  WeatherApp_Sadidur
//
//  Created by Md Sadidur Rahman on 16/3/24.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {
    @IBOutlet weak var animationContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Lottie animation
        let animationView = LottieAnimationView(name: "launch")
        animationView.frame = animationContainerView.bounds
        animationView.contentMode = .scaleAspectFit
        animationContainerView.addSubview(animationView)
        
        // Play animation
        animationView.play { [weak self] (finished) in
            // Transition to home screen
           self?.presentHomeScreen()
        }
    }
    
    private func presentHomeScreen() {
        let homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherViewController")
        homeViewController.modalPresentationStyle = .fullScreen
        present(homeViewController, animated: true, completion: nil)
    }
}
