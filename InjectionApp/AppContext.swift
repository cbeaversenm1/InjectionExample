//
//  AppContext.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import UIKit

protocol Dependency { }

open class AppContext: Dependency {
    let analytics: Analyticable
    let flagManager: any FlagManagable

    init(analytics: Analyticable, flagManager: any FlagManagable) {
        self.analytics = analytics
        self.flagManager = flagManager
    }

    func landingCoordinator(navigationController: UINavigationController?) -> LandingCoordinator {
        LandingCoordinator(
            context: LandingContext(analytics: analytics, flagManager: flagManager),
            navigationController: navigationController
        )
    }
}
