//
//  LandingContext.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI

final class LandingContext<FlagManager: FlagManagable>: AppContext<FlagManager> {

    func landingScreen(delegate: LandingDelegate) -> UIHostingController<LandingScreen> {
        UIHostingController(
            rootView: LandingScreen(
                viewModel: LandingViewModel(delegate: delegate)
            )
        )
    }

    func transactionDetailsCoordinator<DataProvider: TransactionDetailsDataProvidable>(navigationController: UINavigationController?, dataProvider: DataProvider) -> TransactionsCoordinator<FlagManager, DataProvider> {
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
