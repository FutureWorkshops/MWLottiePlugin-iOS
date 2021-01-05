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
    
    private let animationView = AnimationView()
    private var imageView: UIImageView? {
        return self.view.subviews.first?.subviews.first?.subviews.first?.subviews.first?.subviews.first(where: { $0 is UIImageView }) as? UIImageView
    }
    private var lottieStep: MWLottieStep {
        guard let mapStep = self.step as? MWLottieStep else {
            preconditionFailure("Unexpected step type. Expecting \(String(describing: MWLottieStep.self)), got \(String(describing: type(of: self.step)))")
        }
        
        return mapStep
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dummyImageView = self.imageView {
            self.animationView.frame = dummyImageView.bounds
            self.animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            dummyImageView.addSubview(self.animationView)
            
            Animation.loadedFrom(url: self.lottieStep.remoteAnimationURL, closure: { [weak self] animationOrNil in
                guard let animation = animationOrNil else {
                    assertionFailure("Failed to load animation")
                    return
                }
                
                guard let strongSelf = self else { return }
                
                strongSelf.animationView.animation = animation
                strongSelf.animationView.loopMode = .loop
                strongSelf.animationView.play()
            }, animationCache: LRUAnimationCache.sharedCache)
        }
    }
}
