//
//  InjectionProtocolsTests.swift
//  InjectionProtocolsTests
//
//  Created by Chris Beaversen on 10/27/23.
//

@testable import InjectionProtocols

import UIKit
import SwiftUI
import XCTest

final class InjectionProtocolsTests: XCTestCase {
    
    private var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        self.window = UIWindow()
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func testIntegration() {
        let appContext = MockAppContext()
        let appCoordinator = appContext.appCoordinator(
            navigationController: window.rootViewController as? UINavigationController
        )
        appCoordinator.setupCoordinator()
        // Take a picture of the first screen which would be landing coordinator related
        // appCoordinator.navigationController?.paint().assertSnapshot()
        XCTAssert(appCoordinator.navigationController?.viewControllers.contains { $0 is UIHostingController<LandingScreen> } == true)

        let landingScreen = appCoordinator.navigationController?.viewControllers.first(where: { $0 is UIHostingController<LandingScreen> }) as? UIHostingController<LandingScreen>
        // Push transaction details on by sending the button action
        (landingScreen?.rootView as? LandingScreen)?.viewModel.send(.seeTransactionDetails)

        // Take a picture of the second screen which is transactions coordinator
        // appCoordinator.navigationController?.paint().assertSnapshot()
        XCTAssert(appCoordinator.navigationController?.viewControllers.contains { $0 is UIHostingController<TransactionDetailsScreen> } == true)
    }

}

final class MockAppContext: AppDependency {
    let analytics: Analyticable = MockAnalytics()
    let flagManager: any FlagManagable = MockFlagManager()

    func appCoordinator(navigationController: UINavigationController?) -> AppCoordinator {
        AppCoordinator(context: self, navigationController: navigationController)
    }
    
    func landingCoordinator(navigationController: UINavigationController?) -> LandingCoordinator {
        LandingCoordinator(
            context: MockLandingContext(analytics: analytics, flagManager: flagManager),
            navigationController: navigationController
        )
    }
}

final class MockLandingContext: LandingDependency {

    let analytics: Analyticable
    let flagManager: any FlagManagable

    init(analytics: Analyticable, flagManager: any FlagManagable) {
        self.analytics = analytics
        self.flagManager = flagManager
    }

    func landingScreen(delegate: LandingDelegate) -> UIHostingController<LandingScreen> {
        UIHostingController(
            rootView: LandingScreen(
                viewModel: LandingViewModel(
                    delegate: delegate
                )
            )
        )
    }

    func transactionDetailsCoordinator(navigationController: UINavigationController?) -> TransactionsCoordinator {
        return TransactionsCoordinator(
            context: TransactionsContext(
                analytics: analytics,
                flagManager: flagManager,
                dataProvider: MockTransactionDetailsDataProvider() // Ignore the data provider passed to us and replace it with a mocked one
            ),
            navigationController: navigationController
        )
    }
    
    func transactionDetailsDataProvider() -> TransactionDetailsDataProvidable {
        TransactionDetailsDataProvider()
    }
    
    func settingsCoordinator(navigationController: UINavigationController?) -> InjectionProtocols.SettingsCoordinator {
        SettingsCoordinator(
            context: SettingsContext(
                analytics: analytics,
                flagManager: flagManager
            ),
            navigationController: UINavigationController()
        )
    }
}

final class MockAnalytics: Analyticable { }

final class MockFlagManager: FlagManagable { }

final class MockTransactionDetailsDataProvider: TransactionDetailsDataProvidable { }
