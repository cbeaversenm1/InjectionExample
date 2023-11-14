//
//  AppContext.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import UIKit

protocol Dependency { 
    var analytics: Analyticable { get }
    var flagManager: any FlagManagable { get }
}

protocol AppDependency: Dependency {
    func appCoordinator(navigationController: UINavigationController?) -> AppCoordinator
    func landingContext() -> LandingContext
}

extension AppDependency {
    func appCoordinator(navigationController: UINavigationController?) -> AppCoordinator {
        AppCoordinator(context: self, navigationController: navigationController)
    }
}

final class AppContext: AppDependency {
    let analytics: Analyticable = Analytics()
    let flagManager: any FlagManagable = FlagManager()

    func landingCoordinator(navigationController: UINavigationController?) -> LandingCoordinator {
        LandingCoordinator(
            context: landingContext(),
            navigationController: navigationController
        )
    }

    func landingContext() -> LandingContext {
        DefaultLandingContext(analytics: analytics, flagManager: flagManager)
    }
}
