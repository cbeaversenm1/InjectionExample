//
//  TransactionDetailsScreen.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation
import SwiftUI

struct TransactionDetailsScreen<FlagManager: FlagManagable, DataProvider: TransactionDetailsDataProvidable>: View {
    let viewModel: TransactionDetailsViewModel<FlagManager, DataProvider>

    var body: some View {
        Text("Some transactions here")
    }
}
