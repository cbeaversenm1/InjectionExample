//
//  TransactionsCoordinator.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import UIKit

final class TransactionsCoordinator<FlagManager: FlagManagable, DataProvider: TransactionDetailsDataProvidable>: Coordinator {
    var navigationController: UINavigationController?

    let context: TransactionsContext<FlagManager, DataProvider>

    init(context: TransactionsContext<FlagManager, DataProvider>, navigationController: UINavigationController?) {
        self.context = context
        self.navigationController = navigationController
    }
    
    func setupCoordinator() {
        navigationController?.pushViewController(
            context.transactionDetailsScreen(delegate: self),
            animated: true
        )
    }
}

extension TransactionsCoordinator: TransactionDetailsDelegate { }
