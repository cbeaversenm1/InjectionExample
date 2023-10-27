//
//  TransactionsContext.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI

// This makes this fall apart by having to include DataProvider at this level.
// We won't be able to inject this unless we inject it all the way at the top in AppContext
final class TransactionsContext<FlagManager: FlagManagable, DataProvider: TransactionDetailsDataProvidable>: AppContext<FlagManager> {

    let dataProvider: DataProvider

    required init(analytics: Analyticable, flagManager: FlagManager, dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        super.init(analytics: analytics, flagManager: flagManager)
    }

    func transactionDetailsScreen(delegate: TransactionDetailsDelegate) -> UIHostingController<TransactionDetailsScreen<FlagManager, DataProvider>> {
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
