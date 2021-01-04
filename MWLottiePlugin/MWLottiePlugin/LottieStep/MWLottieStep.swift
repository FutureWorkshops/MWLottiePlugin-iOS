//
//  MWLottieStep.swift
//  MWLottiePlugin
//
//  Created by Xavi Moll on 23/12/20.
//

import Foundation
import MobileWorkflowCore

public class MWLottieStep: ORKStep {
    
    let remoteAnimationURL: URL
    
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
    public static func build(step stepInfo: StepInfo, services: MobileWorkflowServices) throws -> ORKStep {
        if let urlString = stepInfo.data.content["lottieFileURL"] as? String, let url = URL(string: urlString) {
            return MWLottieStep(identifier: stepInfo.data.identifier, fileURL: url)
        } else {
            throw NSError(domain: "io.mobileworkflow.lottie", code: 0, userInfo: [NSLocalizedDescriptionKey:"URL to fetch the lottie file missing from the JSON"])
        }
    }
}
