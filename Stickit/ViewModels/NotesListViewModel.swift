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
    @Published var sortMode: NoteSortMode
    @Published private(set) var showsPinnedNotes: Bool
    
    
    private var noteRepository: NoteRepositoryProtocol?
    private var preferencesService: NoteListPreferencesServicing
    
    
    init(noteListPreferencesServicing: NoteListPreferencesServicing? = nil) {
        let preferencesService = noteListPreferencesServicing ?? NoteListPreferencesService()
        self.preferencesService = preferencesService
        self.sortMode = preferencesService.sortMode
        self.showsPinnedNotes = preferencesService.showsPinnedNotes
    }
    
    var displayedNotes: [Note] {
        notes.sorted { left, right in
            switch sortMode {
            case .createNewest:
                 return left.timestamp > right.timestamp
            case .createOldest:
                 return left.timestamp < right.timestamp
            case .editedNewest:
                return left.updatedAt > right.updatedAt
            case .editedOldest:
                return left.updatedAt < right.updatedAt

            }
            
        }
    }
    
    
    var filteredNotes: [Note] {
   
        return displayedNotes
        
    }

    
    var pinnedNote: [Note] {
        filteredNotes.filter(\.isPinned)
    }
    
    
    
    var regularNotes: [Note] {
        filteredNotes.filter { !$0.isPinned }
    }

    
    
    func setSortMode(_ mode: NoteSortMode) {
        sortMode = mode
        preferencesService.sortMode = mode
    }
    
    func openNewNote() {
        editorPayload = NoteEditorPayload(note: nil)
    }
    
    func openEditor(for note: Note) {
        editorPayload = NoteEditorPayload(note: note)
    }
    
    
    
    
    func saveNote(payload: NoteEditorPayload, content: String, color: Int) {
        
        let draft = NoteDraft(content: content,colorHex: color)
        do {
            try noteRepository?.save(payload: payload, draft: draft)
        } catch {
            print("Failed to save note:", error)
            
        }
    }


    func updateNotes(_ notes: [Note]) {
        self.notes = notes
    }
    
    
    func togglePinned(_ note: Note){
        guard let noteRepository else{ return}
        noteRepository.togglePinned(note: note)

    }
    
    func togglePinnedNotesVisibility() {

        showsPinnedNotes.toggle()

        preferencesService.showsPinnedNotes = showsPinnedNotes

    }

    func configure(modelContext: ModelContext) {
        if noteRepository == nil {
            noteRepository = NotePersistenceService(modelContext: modelContext)
        }
    }
  
    func configure(noteRepository: NoteRepositoryProtocol) {
        self.noteRepository = noteRepository
    }
    
    
 
    func deleteNote(_ note: Note) {
        do {
            try noteRepository?.delete(note)
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
