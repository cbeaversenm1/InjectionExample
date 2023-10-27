//
//  TransactionDetailsViewModel.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation

protocol TransactionDetailsDelegate: AnyObject { }

final class TransactionDetailsViewModel {

    let analytics: Analyticable
    let flagManager: any FlagManagable
    let transactionId: String
    let dataProvider: any TransactionDetailsDataProvidable
    weak var delegate: TransactionDetailsDelegate?

    init(
        analytics: Analyticable,
        flagManager: any FlagManagable,
        transactionId: String,
        dataProvider: any TransactionDetailsDataProvidable,
        delegate: TransactionDetailsDelegate
    ) {
        self.analytics = analytics
        self.flagManager = flagManager
        self.transactionId = transactionId
        self.dataProvider = dataProvider
        self.delegate = delegate
    }
}
