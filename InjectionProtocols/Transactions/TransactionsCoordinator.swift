//
//  TransactionsCoordinator.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import UIKit

final class TransactionsCoordinator: Coordinator {
    var navigationController: UINavigationController?

    let context: TransactionsDependency

    // This doesn't need to do anything since this doesn't start children right now
    let coordinators: [Coordinator] = []

    init(context: TransactionsDependency, navigationController: UINavigationController?) {
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
