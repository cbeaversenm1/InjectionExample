//
//  LandingCoordinator.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI
import UIKit

final class LandingCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    let context: LandingContext
    
    // This can be removed once we can handle this memory better
    private var coordinators: [any Coordinator] = []

    init(context: LandingContext, navigationController: UINavigationController? = nil) {
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
        let coordinator = context.transactionsContext().transactionsCoordinator(
            navigationController: navigationController
        )
        coordinators.append(coordinator)
        coordinator.setupCoordinator()
    }
}
