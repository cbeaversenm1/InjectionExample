//
//  InjectionAppTests.swift
//  InjectionAppTests
//
//  Created by Joel McCance on 11/14/23.
//

@testable import InjectionClasses

import UIKit
import SwiftUI
import XCTest

final class InjectionClassesTests: XCTestCase {

    private var window: UIWindow!

    override func setUp() {
        super.setUp()
        self.window = UIWindow()
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    @MainActor
    func testIntegration() async {
        // Create the app context
        let appContext = MockAppContext(
            analytics: MockAnalytics(),
            flagManager: MockFlagManager()
        )
        let appCoordinator = appContext.appCoordinator(
            navigationController: window.rootViewController as? UINavigationController
        )
        appCoordinator.setupCoordinator()

        // Take a picture of the first screen which would be landing coordinator related
        // appCoordinator.navigationController?.paint().assertSnapshot()
        XCTAssert(appCoordinator.navigationController?.viewControllers
                .contains { $0 is UIHostingController<LandingScreen> } == true)

        let landingScreen = appCoordinator.navigationController?.viewControllers.first(where: { $0 is UIHostingController<LandingScreen> }) as? UIHostingController<LandingScreen>

        // Push transaction details on by sending the button action
        (landingScreen?.rootView as? LandingScreen)?.viewModel.send(.seeTransactionDetails)

        // Waiting for animation to complete
        try? await Task.sleep(for: .seconds(1))

        // Take a picture of the second screen which is transactions coordinator
        // appCoordinator.navigationController?.paint().assertSnapshot()
        XCTAssert(appCoordinator.navigationController?.viewControllers.contains { $0 is UIHostingController<TransactionDetailsScreen> } == true)
    }
}

final class MockAppContext: AppContext {
    override func landingContext() -> LandingContext {
        MockLandingContext(analytics: analytics, flagManager: flagManager)
    }
}

final class MockLandingContext: LandingContext {
    override func transactionsContext() -> TransactionsContext {
        MockTransactionsContext(analytics: analytics, flagManager: flagManager)
    }
}

final class MockTransactionsContext: TransactionsContext {
    override func transactionDetailsDataProvider() -> TransactionDetailsDataProvidable {
        MockTransactionDetailsDataProvider()
    }
}


final class MockAnalytics: Analyticable { }

final class MockFlagManager: FlagManagable { }

final class MockTransactionDetailsDataProvider: TransactionDetailsDataProvidable { }
