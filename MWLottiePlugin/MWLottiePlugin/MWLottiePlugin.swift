//
//  MWLottiePlugin.swift
//  MWLottiePlugin
//
//  Created by Xavi Moll on 23/12/20.
//

import Foundation
import MobileWorkflowCore

public struct MWLottiePlugin: Plugin {
    public static var allStepsTypes: [StepType] {
        return MWLottieStepType.allCases
    }
}

public enum MWLottieStepType: String, StepType, CaseIterable {
    
    case instructions = "io.mobileworkflow.LottieInstructions"
    
    public var typeName: String {
        return self.rawValue
    }
    
    public var stepClass: BuildableStep.Type {
        switch self {
        case .instructions: return MWLottieStep.self
        }
    }
}

