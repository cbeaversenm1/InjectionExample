//
//  TransactionsContext.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI

protocol TransactionsContext: Dependency {
    func transactionDetailsScreen(delegate: TransactionDetailsDelegate) -> UIHostingController<TransactionDetailsScreen>

    func transactionsCoordinator(navigationController: UINavigationController?) -> TransactionsCoordinator

    func transactionDetailsDataProvider() -> TransactionDetailsDataProvidable
}

extension TransactionsContext {
    func transactionDetailsScreen(delegate: TransactionDetailsDelegate) -> UIHostingController<TransactionDetailsScreen> {
        UIHostingController(
            rootView: TransactionDetailsScreen(
                viewModel: TransactionDetailsViewModel(
                    analytics: analytics,
                    flagManager: flagManager,
                    transactionId: "1",
                    dataProvider: transactionDetailsDataProvider(),
                    delegate: delegate
                )
            )
        )
    }

    func transactionsCoordinator(navigationController: UINavigationController?) -> TransactionsCoordinator {
        TransactionsCoordinator(
            context: self,
            navigationController: navigationController
        )
    }
}

final class DefaultTransactionsContext: TransactionsContext {
    let analytics: Analyticable
    let flagManager: any FlagManagable

    required init(
        analytics: Analyticable,
        flagManager: any FlagManagable
    ) {
        self.analytics = analytics
        self.flagManager = flagManager
    }


    func transactionDetailsDataProvider() -> TransactionDetailsDataProvidable {
        TransactionDetailsDataProvider()
    }
}
