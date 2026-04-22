//
//  NoteListViewModel.swift
//  Stickit
//
//  Created by Maisie Ng on 4/22/26.
//

import Foundation
import SwiftUI
import SwiftData
import Combine


@MainActor
final class NotesListViewModel: ObservableObject {
    
    @Published private(set) var notes: [Note] = Note.mocks
    
}

extension Note {
    
    static var mock: Note {
        Note(
            id: UUID(),
            title: "Grocery List 🛒",
            content: "Milk 2L, eggs (12), bread, chicken breast, spinach, avocado x2, coffee beans",
            timestamp: Date(),
            updatedAt: Date(),
            isPinned: true,
        )
    }
    
    static var mocks: [Note] {
        [
            
            Note(
                id: UUID(),
                title: "Weekly Groceries",
                content: "Rice, salmon, broccoli, apples, almond milk, yogurt, pasta",
                timestamp: Date(),
                updatedAt: Date(),
                isPinned: false,
            ),
            
            Note(
                id: UUID(),
                title: "Quick Store Run",
                content: "Snacks, soda, ice cream",
                timestamp: Date().addingTimeInterval(-3600),
                updatedAt: Date(),
                isPinned: false,
            ),
            
            Note(
                id: UUID(),
                title: "Meal Prep Ingredients",
                content: "Chicken breast, sweet potatoes, green beans, olive oil, garlic",
                timestamp: Date().addingTimeInterval(-7200),
                updatedAt: Date(),
                isPinned: false,
            ),
            
            Note(
                id: UUID(),
                title: "Produce List",
                content: "Spinach, kale, tomatoes, cucumbers, bananas, blueberries",
                timestamp: Date().addingTimeInterval(-86400),
                updatedAt: Date(),
                isPinned: false,
            ),
            
            Note(
                id: UUID(),
                title: "Dairy Items",
                content: "Milk, cheese, butter, Greek yogurt",
                timestamp: Date().addingTimeInterval(-200000),
                updatedAt: Date(),
                isPinned: false,
            ),
            
            Note(
                id: UUID(),
                title: "Bulk Shopping",
                content: "Paper towels, toilet paper, detergent, bottled water",
                timestamp: Date(),
                updatedAt: Date(),
                isPinned: true,
            ),
            
            mock
        ]
    }
}
