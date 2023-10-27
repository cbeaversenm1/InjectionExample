//
//  TransactionsContext.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI

protocol TransactionsDependency: Dependency {
    var dataProvider: any TransactionDetailsDataProvidable { get }
    func transactionDetailsScreen(delegate: TransactionDetailsDelegate) -> UIHostingController<TransactionDetailsScreen>
}

final class TransactionsContext: TransactionsDependency {
    let analytics: Analyticable
    let flagManager: any FlagManagable
    let dataProvider: any TransactionDetailsDataProvidable

    required init(analytics: Analyticable, flagManager: any FlagManagable, dataProvider: any TransactionDetailsDataProvidable) {
        self.analytics = analytics
        self.flagManager = flagManager
        self.dataProvider = dataProvider
    }

    func transactionDetailsScreen(delegate: TransactionDetailsDelegate) -> UIHostingController<TransactionDetailsScreen> {
        UIHostingController(
            rootView: TransactionDetailsScreen(
                viewModel: TransactionDetailsViewModel(
                    analytics: analytics,
                    flagManager: flagManager,
                    transactionId: "1",
                    dataProvider: dataProvider,
                    delegate: delegate
                )
            )
        )
    }
}
