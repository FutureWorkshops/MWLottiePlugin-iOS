//
//  MWLottieViewController.swift
//  MWLottiePlugin
//
//  Created by Xavi Moll on 23/12/20.
//

import Lottie
import Foundation
import MobileWorkflowCore

public class MWLottieViewController: MWInstructionStepViewController {
    
    //MARK: private properties
    private var lottieStep: MWLottieStep { self.mwStep as! MWLottieStep }
    
    //MARK: Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let placeholderView: UIView = self.imageView
        
        let animationView = AnimationView()
        animationView.frame = placeholderView.bounds
        animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        placeholderView.addSubview(animationView)
        
        Animation.loadedFrom(url: self.lottieStep.remoteAnimationURL, closure: { animationOrNil in
            guard let animation = animationOrNil else {
                assertionFailure("Failed to load animation")
                return
            }
            
            animationView.animation = animation
            animationView.loopMode = .loop
            animationView.play()
        }, animationCache: LRUAnimationCache.sharedCache)
    }
}
