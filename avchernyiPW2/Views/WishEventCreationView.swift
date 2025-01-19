//
//  WishEventCreationView.swift
//  avchernyiPW2
//
//  Created by Алексей on 05.12.2024.
//

import UIKit

// MARK: - WishEventCreationView
final class WishEventCreationView : UIViewController {
    
    // MARK: - Properties
    private let eventManager: CalendarEventManager = CalendarEventManager();
    private let wrapTitleView: UIView = UIView()
    private let wrapNoteView: UIView = UIView()
    private let startDatePicker: UIDatePicker = UIDatePicker()
    private let endDatePicker: UIDatePicker = UIDatePicker()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = UIColor(white: 1, alpha: 0.95)
        configureUI()
        
    }
    
    // MARK: - Private Functions
    private func configureUI() {
        configureTitle()
        configureNote()
        ConfigureStartPicker()
        ConfigureEndPicker()
    }
    
    private func configureTitle() {
        
    }
    
    private func configureNote() {
        
    }
    
    private func ConfigureStartPicker() {
        view.addSubview(startDatePicker)
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startDatePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func ConfigureEndPicker() {
        
    }
    
    private func createEvent() {
        let event = CalendarEventModel(
            title: "Aaaa",
            startDate: Date(),
            endDate: Date().addingTimeInterval(3600),
            note: "Note"
        )
        
        let isCreated = eventManager.create(eventModel: event)
        print(isCreated)
    }
}
