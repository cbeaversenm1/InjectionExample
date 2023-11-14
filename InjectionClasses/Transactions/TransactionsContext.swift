//
//  TransactionsContext.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI

open class TransactionsContext {

    private let analytics: Analyticable
    private let flagManager: any FlagManagable

    init(
        analytics: Analyticable,
        flagManager: any FlagManagable
    ) {
        self.analytics = analytics
        self.flagManager = flagManager
    }

    convenience init(parent: LandingContext) {
        self.init(
            analytics: parent.analytics,
            flagManager: parent.flagManager
        )
    }

    func transactionsCoordinator(navigationController: UINavigationController?) -> TransactionsCoordinator {
        TransactionsCoordinator(
            context: self,
            navigationController: navigationController
        )
    }

    func transactionDetailsScreen(delegate: TransactionDetailsDelegate) -> UIHostingController<TransactionDetailsScreen> {
        UIHostingController(
            rootView: TransactionDetailsScreen(
                viewModel: transactionsDetailsViewModel(delegate)
            )
        )
    }

    func transactionsDetailsViewModel(_ delegate: TransactionDetailsDelegate) -> TransactionDetailsViewModel {
        TransactionDetailsViewModel(
            analytics: analytics,
            flagManager: flagManager,
            transactionId: "1",
            dataProvider: transactionDetailsDataProvider(),
            delegate: delegate
        )
    }

    func transactionDetailsDataProvider() -> TransactionDetailsDataProvidable {
        TransactionDetailsDataProvider()
    }
}
