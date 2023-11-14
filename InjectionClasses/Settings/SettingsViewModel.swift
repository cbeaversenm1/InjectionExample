//
//  SettingsViewModel.swift
//  InjectionProtocols
//
//  Created by Chris Beaversen on 10/27/23.
//

import Foundation

protocol SettingsDelegate: AnyObject { }

final class SettingsViewModel {
    
    weak var delegate: SettingsDelegate?

    init(delegate: SettingsDelegate) {
        self.delegate = delegate
    }
}
