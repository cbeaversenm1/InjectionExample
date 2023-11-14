//
//  Analytics.swift
//  InjectionApp
//
//  Created by Chris Beaversen on 10/26/23.
//

import Foundation

public protocol Analyticable { }

// This is a struct because it doesn't need state, right?
// If it's not a struct, we don't have to use generics to pass it by protocol into places
struct Analytics: Analyticable { }
