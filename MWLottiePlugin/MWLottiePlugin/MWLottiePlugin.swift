//
//  MWLottiePlugin.swift
//  MWLottiePlugin
//
//  Created by Xavi Moll on 23/12/20.
//

import Foundation
import MobileWorkflowCore

public struct MWLottiePlugin: MobileWorkflowPlugin {
    public static var allStepsTypes: [MobileWorkflowStepType] {
        return MWLottieStepType.allCases
    }
}

public enum MWLottieStepType: String, MobileWorkflowStepType, CaseIterable {
    
    case instructions = "io.mobileworkflow.LottieInstructions"
    
    public var typeName: String {
        return self.rawValue
    }
    
    public var stepClass: MobileWorkflowStep.Type {
        switch self {
        case .instructions: return MWLottieStep.self
        }
    }
}

