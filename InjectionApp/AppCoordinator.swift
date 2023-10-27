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

final class AppCoordinator<FlagManager: FlagManagable>: Coordinator {

    private let context: AppContext<FlagManager>
    weak var navigationController: UINavigationController?

    // This can be removed once we can handle this memory better
    private var coordinators: [any Coordinator] = []

    init(
        context: AppContext<FlagManager>,
        navigationController: UINavigationController
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
