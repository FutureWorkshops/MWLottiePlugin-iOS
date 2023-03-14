//
//  MWLottieStep.swift
//  MWLottiePlugin
//
//  Created by Xavi Moll on 23/12/20.
//

import Foundation
import MobileWorkflowCore
import UIKit

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
        MWLottieViewController(instructionStep: self)
    }
}

extension MWLottieStep: BuildableStep {
    
    public static var mandatoryCodingPaths: [CodingKey] {
        ["lottieFileURL"]
    }
    
    public static func build(stepInfo: StepInfo, services: StepServices) throws -> Step {
        guard let urlString = stepInfo.data.content["lottieFileURL"] as? String, let url = URL(string: urlString) else {
            throw ParseError.invalidStepData(cause: "Missing or malformed 'lottieFileURL' property")
        }
        let step = MWLottieStep(identifier: stepInfo.data.identifier, fileURL: url, session: stepInfo.session, services: services)
        step.text = services.localizationService.translate(stepInfo.data.content["text"] as? String)
        return step
    }
}

public class LottieAnimatedInstructionsMetadata: StepMetadata {
    enum CodingKeys: CodingKey {
        case text
        case lottieFileURL
    }
    
    let text: String?
    let lottieFileURL: String?
    
    init(id: String, title: String, text: String?, lottieFileURL: String?, next: PushLinkMetadata?, links: [PushLinkMetadata]) {
        self.text = text
        self.lottieFileURL = lottieFileURL
        super.init(id: id, type: "io.mobileworkflow.LottieInstructions", title: title, next: next, links: links)
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.lottieFileURL = try container.decodeIfPresent(String.self, forKey: .lottieFileURL)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.text, forKey: .text)
        try container.encodeIfPresent(self.lottieFileURL, forKey: .lottieFileURL)
        try super.encode(to: encoder)
    }
}

public extension StepMetadata {
    static func lottieAnimatedInstructions(
        id: String,
        title: String,
        text: String? = nil,
        lottieFileURL: String? = nil,
        next: PushLinkMetadata? = nil,
        links: [PushLinkMetadata] = []
    ) -> LottieAnimatedInstructionsMetadata {
        LottieAnimatedInstructionsMetadata(id: id, title: title, text: text, lottieFileURL: lottieFileURL, next: next, links: links)
    }
}
