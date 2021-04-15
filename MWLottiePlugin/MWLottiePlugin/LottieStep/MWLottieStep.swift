//
//  MWLottieStep.swift
//  MWLottiePlugin
//
//  Created by Xavi Moll on 23/12/20.
//

import Foundation
import MobileWorkflowCore

public class MWLottieStep: ORKInstructionStep {
    
    let remoteAnimationURL: URL
    /// This UIImage **always** returns an emtpy image. It's only used for positioning the lottie animation in the correct place.
    /// Setting a value to this property does nothing in this subclass.
    public override var image: UIImage? {
        get { UIImage() }
        set {}
    }
    
    init(identifier: String, fileURL: URL) {
        self.remoteAnimationURL = fileURL
        super.init(identifier: identifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func stepViewControllerClass() -> AnyClass {
        return MWLottieViewController.self
    }
}

extension MWLottieStep: MobileWorkflowStep {
    public static func build(stepInfo: StepInfo, services: StepServices) throws -> Step {
        if let urlString = stepInfo.data.content["lottieFileURL"] as? String, let url = URL(string: urlString) {
            let step = MWLottieStep(identifier: stepInfo.data.identifier, fileURL: url)
            step.text = services.localizationService.translate(stepInfo.data.content["text"] as? String)
            return step
        } else {
            throw NSError(domain: "io.mobileworkflow.lottie", code: 0, userInfo: [NSLocalizedDescriptionKey:"URL to fetch the lottie file missing from the JSON"])
        }
    }
}
