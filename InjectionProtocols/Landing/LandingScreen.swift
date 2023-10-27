//
//  LandingScreen.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI

struct LandingScreen: View {
    let viewModel: LandingViewModel

    var body: some View {
        Button(action: {
            viewModel.send(.seeTransactionDetails)
        }, label: {
            Text("See transactions")
        })
        Button(action: {
            viewModel.send(.seeSettings)
        }, label: {
            Text("See settings")
        })
    }
}
