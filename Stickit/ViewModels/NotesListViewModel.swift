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

    @Published private(set) var notes:[Note] = []
    @Published var editorPayload: NoteEditorPayload?
    
    private var noteRespositoryProtocol: NoteRepositoryProtocol?
    
    func openNewNote() {
        editorPayload = NoteEditorPayload(note: nil)
    }
    
    func openEditor(for note: Note) {
        editorPayload = NoteEditorPayload(note: note)
    }
    
    
    
    
    func saveNote(payload: NoteEditorPayload, content: String, color: Int) {
        
        let draft = NoteDraft(content: content,colorHex: color)
        do {
            try noteRespositoryProtocol?.save(payload: payload, draft: draft)
        } catch {
            print("Failed to save note:", error)
            
        }
    }


    func updateNotes(_ notes: [Note]) {
        self.notes = notes
    }

    func configure(modelContext: ModelContext) {
        if noteRespositoryProtocol == nil {
            noteRespositoryProtocol = NotePersistenceService(modelContext: modelContext)
        }
    }
  
    func configure(noteRespositoryProtocol: NoteRepositoryProtocol) {
        self.noteRespositoryProtocol = noteRespositoryProtocol
    }
    
    
 
    func deleteNote(_ note: Note) {
        do {
            try noteRespositoryProtocol?.delete(note)
        } catch {
            print("Failed to delete note:", error)
        }
    }
  

}

extension Note {
    
    static var mock: Note {
        Note(
            id: UUID(),
            content: """
            Grocery List 🛒
            Milk 2L, eggs (12), bread, chicken breast, spinach, avocado x2, coffee beans
            """,
            timestamp: Date(),
            updatedAt: Date(), color: .blushClay,
            isPinned: true,
        )
    }
    
    static var mocks: [Note] {
        [
            
            Note(
                id: UUID(),
                content: """
                Weekly Groceries
                Rice, salmon, broccoli, apples, almond milk, yogurt, pasta
                """,
                timestamp: Date(),
                updatedAt: Date(), color: .ashGray,
                isPinned: false,
            ),
            
            Note(
                id: UUID(),
                content: """
                Quick Store Run
                Snacks, soda, ice cream
                """,
                timestamp: Date().addingTimeInterval(-3600),
                updatedAt: Date(),
                color: .skyBlue,
                isPinned: false,
            ),
            
            Note(
                id: UUID(),
                content: """
                Meal Prep Ingredients
                Chicken breast, sweet potatoes, green beans, olive oil, garlic
                """,
                timestamp: Date().addingTimeInterval(-7200),
                updatedAt: Date(),
                color: .softIndigo,
                isPinned: false,
            ),
            
            Note(
                id: UUID(),
                content: """
                Produce List
                Spinach, kale, tomatoes, cucumbers, bananas, blueberries
                """,
                timestamp: Date().addingTimeInterval(-86400),
                updatedAt: Date(),
                color: .skyBlue,
                isPinned: false,
            ),
            
            Note(
                id: UUID(),
                content: """
                Dairy Items
                Milk, cheese, butter, Greek yogurt
                """,
                timestamp: Date().addingTimeInterval(-200000),
                updatedAt: Date(),
                color: .skyBlue,
                isPinned: false,
            ),
            
            Note(
                id: UUID(),
                content: """
                Bulk Shopping
                Paper towels, toilet paper, detergent, bottled water
            """,
                timestamp: Date(),
                updatedAt: Date(),
                color: .skyBlue,
                isPinned: true,
            )
            
        ]
    }
}
