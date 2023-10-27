//
//  LandingContext.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI

protocol LandingDependency: Dependency {
    func landingScreen(delegate: LandingDelegate) -> UIHostingController<LandingScreen>
    func transactionDetailsCoordinator(navigationController: UINavigationController?) -> TransactionsCoordinator
    func transactionDetailsDataProvider() -> TransactionDetailsDataProvidable
    func settingsCoordinator(navigationController: UINavigationController?) -> SettingsCoordinator
}

final class LandingContext: LandingDependency {

    let analytics: Analyticable
    let flagManager: any FlagManagable

    init(analytics: Analyticable, flagManager: any FlagManagable) {
        self.analytics = analytics
        self.flagManager = flagManager
    }
    
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

    func transactionDetailsCoordinator(navigationController: UINavigationController?) -> TransactionsCoordinator {
        TransactionsCoordinator(
            context: TransactionsContext(
                analytics: analytics,
                flagManager: flagManager,
                dataProvider: transactionDetailsDataProvider()
            ),
            navigationController: navigationController
        )
    }

    func transactionDetailsDataProvider() -> TransactionDetailsDataProvidable {
        TransactionDetailsDataProvider()
    }
    
    func settingsCoordinator(navigationController: UINavigationController?) -> SettingsCoordinator {
        SettingsCoordinator(
            context: SettingsContext(analytics: analytics, flagManager: flagManager),
            navigationController: navigationController
        )
    }
}
