//
//  MWLottieViewController.swift
//  MWLottiePlugin
//
//  Created by Xavi Moll on 23/12/20.
//

import Lottie
import Foundation
import MobileWorkflowCore

public class MWLottieViewController: ORKInstructionStepViewController {
    
    //MARK: private properties
    private var lottieStep: MWLottieStep { self.step as! MWLottieStep }
    
    //MARK: Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if let placeholderImageView = self.imageView {
            let animationView = AnimationView()
            animationView.frame = placeholderImageView.bounds
            animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            placeholderImageView.addSubview(animationView)
            
            Animation.loadedFrom(url: self.lottieStep.remoteAnimationURL, closure: { animationOrNil in
                guard let animation = animationOrNil else {
                    assertionFailure("Failed to load animation")
                    return
                }
                
                animationView.animation = animation
                animationView.loopMode = .loop
                animationView.play()
            }, animationCache: LRUAnimationCache.sharedCache)
        } else {
            assertionFailure("The lottie animation won't be shown because the imageView is missing and we don't know where to place it")
        }
    }
}
