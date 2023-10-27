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
    var coordinators: [any Coordinator] { get }
    func setupCoordinator()
}

final class AppCoordinator: Coordinator {

    private let context: any AppDependency
    weak var navigationController: UINavigationController?

    // This can be removed once we can handle this memory better
    private(set) var coordinators: [any Coordinator] = []

    init(
        context: any AppDependency,
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
