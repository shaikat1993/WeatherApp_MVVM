//
//  ErrorViewController.swift
//  WeatherApp_Sadidur
//
//  Created by Md Sadidur Rahman on 16/3/24.
//

import UIKit
import Lottie

class ErrorViewController: UIViewController {
    
    @IBOutlet weak var cloudAnimation: LottieAnimationView!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        updateUI()
    }
    
    func updateUI() {
        tryAgainButton.layer.cornerRadius = 10
        tryAgainButton.layer.masksToBounds = false
        
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.masksToBounds = false
        
        cloudAnimation.loopMode = .loop
        cloudAnimation.play()
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        dismiss(animated: true)
    }
}
