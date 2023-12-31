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

    @MainActor
    func testIntegration() async throws {
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

        try await Task.sleep(for: .seconds(1))

        // Take a picture of the second screen which is transactions coordinator
        // appCoordinator.navigationController?.paint().assertSnapshot()
        XCTAssert(appCoordinator.navigationController?.viewControllers.contains { $0 is UIHostingController<TransactionDetailsScreen> } == true)
    }

}

final class MockAppContext: AppDependency {
    let analytics: Analyticable = MockAnalytics()
    let flagManager: any FlagManagable = MockFlagManager()

    func landingContext() -> LandingContext {
        MockLandingContext(analytics: analytics, flagManager: flagManager)
    }
}

final class MockLandingContext: LandingContext {
    let analytics: Analyticable
    let flagManager: any FlagManagable

    init(analytics: Analyticable, flagManager: any FlagManagable) {
        self.analytics = analytics
        self.flagManager = flagManager
    }


    func transactionsContext() -> TransactionsContext {
        MockTransactionsContext(analytics: analytics, flagManager: flagManager)
    }
    
    func settingsContext() -> InjectionProtocols.SettingsContext {
        MockSettingsContext(analytics: analytics, flagManager: flagManager)
    }
}

final class MockSettingsContext: SettingsContext {
    let analytics: Analyticable
    let flagManager: any FlagManagable

    init(analytics: Analyticable, flagManager: any FlagManagable) {
        self.analytics = analytics
        self.flagManager = flagManager
    }
}

final class MockTransactionsContext: TransactionsContext {
    let analytics: Analyticable
    let flagManager: any FlagManagable

    init(analytics: Analyticable, flagManager: any FlagManagable) {
        self.analytics = analytics
        self.flagManager = flagManager
    }

    func transactionDetailsDataProvider() -> InjectionProtocols.TransactionDetailsDataProvidable {
        MockTransactionDetailsDataProvider()
    }
}

final class MockAnalytics: Analyticable { }

final class MockFlagManager: FlagManagable { }

final class MockTransactionDetailsDataProvider: TransactionDetailsDataProvidable { }
