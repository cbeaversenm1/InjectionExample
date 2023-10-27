//
//  AppContext.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import UIKit

protocol Dependency { }

open class AppContext<FlagManager: FlagManagable>: Dependency {
    let analytics: Analyticable
    let flagManager: FlagManager

    init(analytics: Analyticable, flagManager: FlagManager) {
        self.analytics = analytics
        self.flagManager = flagManager
    }

    func landingCoordinator(navigationController: UINavigationController?) -> LandingCoordinator<FlagManager> {
        LandingCoordinator(
            context: LandingContext(analytics: analytics, flagManager: flagManager),
            navigationController: navigationController
        )
    }
}
