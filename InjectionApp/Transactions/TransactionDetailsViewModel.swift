//
//  TransactionDetailsViewModel.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation

protocol TransactionDetailsDelegate: AnyObject { }

final class TransactionDetailsViewModel<FlagManager: FlagManagable, DataProvider: TransactionDetailsDataProvidable> {

    let analytics: Analyticable
    let flagManager: FlagManager
    let transactionId: String
    let dataProvider: DataProvider
    weak var delegate: TransactionDetailsDelegate?

    init(
        analytics: Analyticable,
        flagManager: FlagManager,
        transactionId: String,
        dataProvider: DataProvider,
        delegate: TransactionDetailsDelegate
    ) {
        self.analytics = analytics
        self.flagManager = flagManager
        self.transactionId = transactionId
        self.dataProvider = dataProvider
        self.delegate = delegate
    }
}
