//
//  UserDefaultsHelper.swift
//  avchernyiPW2
//
//  Created by Алексей on 28.11.2024.
//

import Foundation
import UIKit

final class UserDefaultsHelper {
    // MARK: - Constants
    enum Constants {
        static let wishesKey = "wishes"
    }
    // MARK: - Variables
    private let defaults = UserDefaults.standard
    
    // MARK: - Functions
    func saveWishes(_ wishes: [String]) {
        defaults.set(wishes, forKey: Constants.wishesKey)
    }
    
    func loadWishes() -> [String] {
        return defaults.stringArray(forKey: Constants.wishesKey) ?? []
    }
}
