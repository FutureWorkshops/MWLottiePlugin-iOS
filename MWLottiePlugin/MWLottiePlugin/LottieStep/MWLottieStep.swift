//
//  MWLottieStep.swift
//  MWLottiePlugin
//
//  Created by Xavi Moll on 23/12/20.
//

import Foundation
import MobileWorkflowCore

public class MWLottieStep: MWStep, InstructionStep {
    
    public var imageURL: String? { return nil }
    public var session: Session
    public var services: StepServices
    
    let remoteAnimationURL: URL
    /// This UIImage **always** returns an emtpy image. It's only used for positioning the lottie animation in the correct place.
    /// Setting a value to this property does nothing in this subclass.
    public var image: UIImage? {
        get { UIImage() }
        set {}
    }
    
    init(identifier: String, fileURL: URL, session: Session, services: StepServices) {
        self.remoteAnimationURL = fileURL
        self.session = session
        self.services = services
        super.init(identifier: identifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func instantiateViewController() -> StepViewController {
        MWLottieViewController(step: self)
    }
}

extension MWLottieStep: BuildableStep {
    public static func build(stepInfo: StepInfo, services: StepServices) throws -> Step {
        if let urlString = stepInfo.data.content["lottieFileURL"] as? String, let url = URL(string: urlString) {
            let step = MWLottieStep(identifier: stepInfo.data.identifier, fileURL: url, session: stepInfo.session, services: services)
            step.text = services.localizationService.translate(stepInfo.data.content["text"] as? String)
            return step
        } else {
            throw ParseError.invalidStepData(cause: "URL to fetch the lottie file missing from the JSON")
        }
    }
}
