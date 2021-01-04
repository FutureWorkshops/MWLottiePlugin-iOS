//
//  MWLottieViewController.swift
//  MWLottiePlugin
//
//  Created by Xavi Moll on 23/12/20.
//

import Lottie
import Foundation
import MobileWorkflowCore

public class MWLottieViewController: ORKStepViewController, RemoteContentStepViewController, ContentClearable {
    
    public typealias StepType = MWLottieStep
    public var remoteContentStep: MWLottieStep! { return (self.step as! MWLottieStep) }
    public var workflowPresentationDelegate: WorkflowPresentationDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.resyncContent()
    }
    
    public func showLoading() {
        
    }
    
    public func hideLoading() {
        
    }
    
    public func update(content: Data) {
        dump(content)
    }
    
    public func clearContent() {
        
    }
}
