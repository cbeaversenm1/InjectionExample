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
    let context: LandingDependency

    // This can be removed once we can handle this memory better
    private(set) var coordinators: [any Coordinator] = []

    init(context: LandingDependency, navigationController: UINavigationController? = nil) {
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
            navigationController: navigationController
        )
        coordinators.append(coordinator)
        coordinator.setupCoordinator()
    }

    func seeSettings() {
        let navigationController = UINavigationController()
        let coordinator = context.settingsCoordinator(navigationController: navigationController)
        coordinators.append(coordinator)
        coordinator.setupCoordinator()
        self.navigationController?.present(coordinator.navigationController!, animated: true)
    }
}
