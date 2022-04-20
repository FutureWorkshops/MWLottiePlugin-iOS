//
//  SceneDelegate.swift
//  MWLottie
//
//  Created by Xavi Moll on 23/12/20.
//  Copyright © 2020 Future Workshops. All rights reserved.
//

import UIKit
import MobileWorkflowCore
import MWLottiePlugin

class SceneDelegate: MWSceneDelegate {
    
    override func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        self.dependencies.plugins = [MWLottiePluginStruct.self]
        
        super.scene(scene, willConnectTo: session, options: connectionOptions)
    }
}
