//
//  AppConfiguration.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import Foundation

final class AppConfiguration {
    lazy var apiBaseURL: String = {
        return "https://api.github.com/"
    }()
}
