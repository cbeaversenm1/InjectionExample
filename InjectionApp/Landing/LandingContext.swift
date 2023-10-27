//
//  LandingContext.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI

final class LandingContext: AppContext {

    func landingScreen(delegate: LandingDelegate) -> UIHostingController<LandingScreen> {
        UIHostingController(
            rootView: LandingScreen(
                viewModel: LandingViewModel(delegate: delegate)
            )
        )
    }

    func transactionDetailsCoordinator(navigationController: UINavigationController?, dataProvider: any TransactionDetailsDataProvidable) -> TransactionsCoordinator {
        TransactionsCoordinator(
            context: TransactionsContext(
                analytics: analytics,
                flagManager: flagManager,
                dataProvider: dataProvider
            ),
            navigationController: navigationController
        )
    }
}
