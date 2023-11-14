//
//  AppContext.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import UIKit

open class AppContext {
    public let analytics: Analyticable
    public let flagManager: any FlagManagable

    init(analytics: Analyticable, flagManager: any FlagManagable) {
        self.analytics = analytics
        self.flagManager = flagManager
    }

    func appCoordinator(navigationController: UINavigationController?) -> AppCoordinator {
        AppCoordinator(context: self, navigationController: navigationController)
    }

    func landingContext() -> LandingContext {
        LandingContext(analytics: analytics, flagManager: flagManager)
    }

    func landingCoordinator(navigationController: UINavigationController?) -> LandingCoordinator {
        LandingCoordinator(
            context: landingContext(),
            navigationController: navigationController
        )
    }
}
