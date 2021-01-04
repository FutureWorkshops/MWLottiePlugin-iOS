//
//  MWLottieStep.swift
//  MWLottiePlugin
//
//  Created by Xavi Moll on 23/12/20.
//

import Foundation
import MobileWorkflowCore

public class MWLottieStep: ORKStep {
    
    // Required to be able to conform to RemoteContentStep down below
    private let _services: MobileWorkflowServices
    private let _authenticationWorkflowId: Int?
    
    private var remoteAnimationURL: URL
    
    init(identifier: String, fileURL: URL, services: MobileWorkflowServices, authenticationWorkflowId: Int?) {
        self.remoteAnimationURL = fileURL
        self._services = services
        self._authenticationWorkflowId = authenticationWorkflowId
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
            return MWLottieStep(identifier: stepInfo.data.identifier,
                                fileURL: url,
                                services: services,
                                authenticationWorkflowId: stepInfo.data.content["authenticationWorkflowId"] as? Int)
        } else {
            throw NSError(domain: "io.mobileworkflow.lottie", code: 0, userInfo: [NSLocalizedDescriptionKey:"URL to fetch the lottie file missing from the JSON"])
        }
    }
}

extension MWLottieStep: RemoteContentStep {
    public typealias ResponseType = Data
    
    public var services: MobileWorkflowServices {
        return self._services
    }
    
    public var contentURL: String? {
        return self.remoteAnimationURL.absoluteString
    }
    
    public var authenticationWorkflowId: Int? {
        return self._authenticationWorkflowId
    }

    public func loadContent(completion: @escaping (Result<Data, Error>) -> Void) {
//        self.perform(url: self.remoteAnimationURL.absoluteString, method: .GET, completion: completion)
        
        #warning("This implementation is wrong, it bypasses the system. For some reason it doesn't seem to be able to decode the JSON as Data")
        let task = URLSession.shared.dataTask(with: URLRequest(url: self.remoteAnimationURL)) { (dataOrNil, responseOrNil, errorOrNil) in
            if let error = errorOrNil {
                completion(.failure(error))
            } else if let data = dataOrNil {
                completion(.success(data))
            } else {
                assertionFailure("No error nor data")
            }
        }
        task.resume()
    }
}

extension MWLottieStep: SyncableContentSource {
    public var resolvedURL: URL? {
        get {
            return self.remoteAnimationURL
        }
        set {
            self.remoteAnimationURL = newValue ?? self.remoteAnimationURL
        }
    }
}

