//
//  LoadingViewController.swift
//  MVPExample
//
//  Created by Javier Pineda Gonzalez on 17/08/22.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {

    @IBOutlet weak var loadingAnimation: AnimationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingAnimation.loopMode = .loop
        loadingAnimation.contentMode = .scaleAspectFit
        loadingAnimation.play()
    }
}
