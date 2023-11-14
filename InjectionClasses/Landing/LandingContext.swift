//
//  LandingContext.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI

open class LandingContext {

    let analytics: Analyticable
    let flagManager: any FlagManagable

    init(
        analytics: Analyticable,
        flagManager: any FlagManagable
    ) {
        self.analytics = analytics
        self.flagManager = flagManager
    }

    convenience init(parent: AppContext) {
        self.init(
            analytics: parent.analytics,
            flagManager: parent.flagManager
        )
    }

    func landingScreen(delegate: LandingDelegate) -> UIHostingController<LandingScreen> {
        UIHostingController(
            rootView: LandingScreen(
                viewModel: LandingViewModel(delegate: delegate)
            )
        )
    }

    func transactionsContext() -> TransactionsContext {
        return TransactionsContext(analytics: analytics, flagManager: flagManager)
    }

}
