//
//  AppCoordinator.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func setupCoordinator()
}

// Brainstorming around trying to fixup the navigation related
// apis with confusion around presenting / pushing new coordinators
extension Coordinator {
    func presentCoordinator(coordinator: Coordinator) {
        let newNav = UINavigationController()
        navigationController?.present(newNav, animated: true)
    }
}

final class AppCoordinator: Coordinator {

    private let context: AppContext
    weak var navigationController: UINavigationController?

    // This can be removed once we can handle this memory better
    private var coordinators: [any Coordinator] = []

    init(
        context: AppContext,
        navigationController: UINavigationController?
    ) {
        self.context = context
        self.navigationController = navigationController
    }

    func setupCoordinator() {
        let landingCoordinator = context.landingCoordinator(navigationController: navigationController)
        coordinators.append(landingCoordinator)
        landingCoordinator.setupCoordinator()
    }
}
