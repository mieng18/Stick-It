//
//  NotePersistenceService.swift
//  Stickit
//
//  Created by Maisie Ng on 4/25/26.
//

import Foundation
import SwiftData


protocol NoteRepositoryProtocol {
    func save(payload: NoteEditorPayload,draft: NoteDraft) throws
    func delete(_ note: Note)throws

}

struct NotePersistenceService: NoteRepositoryProtocol {

    
  
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func save(payload: NoteEditorPayload, draft: NoteDraft) throws {
        if let existingNote = payload.note {
            existingNote.content = draft.content
            existingNote.colorHex = draft.colorHex
        } else {
            let newNote = Note(
                content: draft.content,
                timestamp: .now,
                updatedAt: .now,
                color: NotePalette(rawValue: draft.colorHex) ?? .ashGray,
                isPinned: false
            )
            modelContext.insert(newNote)
        }
        
        try modelContext.save()
    }
    
    
    func delete(_ note: Note) throws {
        modelContext.delete(note)
        try modelContext.save()
        
        persistChanges()

    }
    
    private func persistChanges() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to persist note changes: \(error)")
        }
    }
}

