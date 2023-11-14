//
//  LandingContext.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI

protocol LandingContext: Dependency {
    func landingCoordinator(navigationController: UINavigationController?) -> LandingCoordinator
    func landingScreen(delegate: LandingDelegate) -> UIHostingController<LandingScreen>
    func transactionsContext() -> TransactionsContext
    func settingsContext() -> SettingsContext
}

extension LandingContext {
    func landingCoordinator(navigationController: UINavigationController?) -> LandingCoordinator {
        LandingCoordinator(context: self, navigationController: navigationController)
    }

    func landingScreen(delegate: LandingDelegate) -> UIHostingController<LandingScreen> {
        UIHostingController(
            rootView: LandingScreen(
                viewModel: LandingViewModel(delegate: delegate)
            )
        )
    }
}

final class DefaultLandingContext: LandingContext {
    let analytics: Analyticable
    let flagManager: any FlagManagable

    init(analytics: Analyticable, flagManager: any FlagManagable) {
        self.analytics = analytics
        self.flagManager = flagManager
    }

    func transactionsContext() -> TransactionsContext {
        DefaultTransactionsContext(
            analytics: analytics,
            flagManager: flagManager
        )
    }

    func settingsContext() -> SettingsContext {
        DefaultSettingsContext(
            analytics: analytics,
            flagManager: flagManager
        )
    }
}
