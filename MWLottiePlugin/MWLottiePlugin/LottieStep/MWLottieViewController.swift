//
//  MWLottieViewController.swift
//  MWLottiePlugin
//
//  Created by Xavi Moll on 23/12/20.
//

import Lottie
import Foundation
import MobileWorkflowCore

public class MWLottieViewController: ORKStepViewController {
    
    private let animationView = AnimationView()
    private var lottieStep: MWLottieStep {
        guard let mapStep = self.step as? MWLottieStep else {
            preconditionFailure("Unexpected step type. Expecting \(String(describing: MWLottieStep.self)), got \(String(describing: type(of: self.step)))")
        }
        
        return mapStep
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animationView.frame = self.view.bounds
        self.animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(self.animationView)
        
        Animation.loadedFrom(url: self.lottieStep.remoteAnimationURL, closure: { [weak self] animationOrNil in
            guard let animation = animationOrNil else {
                assertionFailure("Failed to load animation")
                return
            }
            
            self?.animationView.animation = animation
            self?.animationView.loopMode = .loop
            self?.animationView.play()
        }, animationCache: nil)
        
    }
}
