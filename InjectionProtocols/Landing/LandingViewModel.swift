//
//  LandingViewModel.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation

protocol LandingDelegate: AnyObject {
    func seeTransactionDetails()
    func seeSettings()
}

final class LandingViewModel {
    
    enum Action {
        case seeTransactionDetails
        case seeSettings
    }

    weak var delegate: LandingDelegate?
    
    init(delegate: LandingDelegate? = nil) {
        self.delegate = delegate
    }

    func send(_ action: Action) {
        switch action {
        case .seeTransactionDetails:
            delegate?.seeTransactionDetails()
        case .seeSettings:
            delegate?.seeSettings()
        }
    }
}
