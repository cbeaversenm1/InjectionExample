//
//  SettingsContext.swift
//  InjectionProtocols
//
//  Created by Chris Beaversen on 10/27/23.
//

import Foundation
import SwiftUI
import UIKit

protocol SettingsContext: Dependency {
    func settingsCoordinator(navigationController: UINavigationController?) -> SettingsCoordinator
    func settingScreen(delegate: SettingsDelegate) -> UIHostingController<SettingsScreen>
}

extension SettingsContext {
    func settingsCoordinator(navigationController: UINavigationController?) -> SettingsCoordinator {
        SettingsCoordinator(context: self, navigationController: navigationController)
    }

    func settingScreen(delegate: SettingsDelegate) -> UIHostingController<SettingsScreen> {
        UIHostingController(
            rootView: SettingsScreen(
                viewModel: SettingsViewModel(delegate: delegate)
            )
        )
    }
}

final class DefaultSettingsContext: SettingsContext {
    let analytics: Analyticable
    let flagManager: any FlagManagable
    
    init(analytics: Analyticable, flagManager: any FlagManagable) {
        self.analytics = analytics
        self.flagManager = flagManager
    }
}
