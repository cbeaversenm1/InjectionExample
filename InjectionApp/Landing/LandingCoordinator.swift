//
//  LandingCoordinator.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI
import UIKit

final class LandingCoordinator<FlagManager: FlagManagable>: Coordinator {
    weak var navigationController: UINavigationController?
    let context: LandingContext<FlagManager>
    
    // This can be removed once we can handle this memory better
    private var coordinators: [any Coordinator] = []

    init(context: LandingContext<FlagManager>, navigationController: UINavigationController? = nil) {
        self.context = context
        self.navigationController = navigationController
    }

    func setupCoordinator() {
        navigationController?.pushViewController(
            context.landingScreen(delegate: self),
            animated: true
        )
    }
}

extension LandingCoordinator: LandingDelegate {
    func seeTransactionDetails() {
        let coordinator = context.transactionDetailsCoordinator(
            navigationController: navigationController,
            dataProvider: TransactionDetailsDataProvider()
        )
        coordinators.append(coordinator)
        coordinator.setupCoordinator()
    }
}
