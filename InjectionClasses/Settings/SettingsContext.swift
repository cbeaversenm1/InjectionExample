//
//  SettingsContext.swift
//  InjectionApp
//
//  Created by Joel McCance on 11/14/23.
//

import Foundation
import SwiftUI
import UIKit

final class SettingsContext {
    let analytics: Analyticable
    let flagManager: any FlagManagable

    init(analytics: Analyticable, flagManager: any FlagManagable) {
        self.analytics = analytics
        self.flagManager = flagManager
    }

    convenience init(parent: LandingContext) {
        self.init(
            analytics: parent.analytics,
            flagManager: parent.flagManager
        )
    }

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
