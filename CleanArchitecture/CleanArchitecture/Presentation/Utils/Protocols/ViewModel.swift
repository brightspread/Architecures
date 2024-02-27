//
//  ViewModel.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import SwiftUI

protocol ViewModel: ObservableObject {
    associatedtype State
    associatedtype Action
    
    var state: State { get }
    func action(_ action: Action)
}
