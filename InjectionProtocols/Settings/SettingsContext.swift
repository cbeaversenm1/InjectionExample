//
//  SettingsContext.swift
//  InjectionProtocols
//
//  Created by Chris Beaversen on 10/27/23.
//

import Foundation
import SwiftUI
import UIKit

protocol SettingsDependency: Dependency {
    func settingsCoordinator(navigationController: UINavigationController?) -> SettingsCoordinator
    func settingScreen(delegate: SettingsDelegate) -> UIHostingController<SettingsScreen>
    func settingsC(present: Bool, f: (SettingsCoordinator) -> Void)
}

final class SettingsContext: SettingsDependency {
    let analytics: Analyticable
    let flagManager: any FlagManagable
    
    init(analytics: Analyticable, flagManager: any FlagManagable) {
        self.analytics = analytics
        self.flagManager = flagManager
    }

    func settingsCoordinator(navigationController: UINavigationController?) -> SettingsCoordinator {
        SettingsCoordinator(context: self, navigationController: navigationController)
    }

    func settingsC(present: Bool, f: (SettingsCoordinator) -> Void) {
        let navigationController = present ? UINavigationController() : self.navigationController
        let coordinator = SettingsCoordinator(context: self, navigationController: navigationController)
        f(coordinator)
    }

    func settingScreen(delegate: SettingsDelegate) -> UIHostingController<SettingsScreen> {
        UIHostingController(
            rootView: SettingsScreen(
                viewModel: SettingsViewModel(delegate: delegate)
            )
        )
    }

}
