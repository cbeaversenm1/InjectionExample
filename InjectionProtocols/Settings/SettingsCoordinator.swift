//
//  SettingsCoordinator.swift
//  InjectionProtocols
//
//  Created by Chris Beaversen on 10/27/23.
//

import Foundation
import UIKit

final class SettingsCoordinator: Coordinator {

    weak var navigationController: UINavigationController?
    let context: SettingsDependency

    // This can be removed once we can handle this memory better
    var coordinators: [any Coordinator] = []

    init(context: SettingsDependency, navigationController: UINavigationController?) {
        self.context = context
        self.navigationController = navigationController
    }

    func setupCoordinator() {
        navigationController?.pushViewController(
            context.settingScreen(delegate: self),
            animated: true
        )
    }

}

extension SettingsCoordinator: SettingsDelegate { }
