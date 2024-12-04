//
//  WishEventModel.swift
//  avchernyiPW2
//
//  Created by Алексей on 05.12.2024.
//

import UIKit

// MARK: - WishEventModel
final class WishEventModel {
    // MARK: - Variables
    var title: String = "Test"
    var description: String = "Test description"
    var startDate: String = "Start date"
    var endDate: String = "End date"
    
    // MARK: - Lifecycle
    init(title: String, description: String, startDate: String, endDate: String) {
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
}
