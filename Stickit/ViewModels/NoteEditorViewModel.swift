//
//  NoteEditorViewModel.swift
//  Stickit
//
//  Created by Maisie Ng on 4/23/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class NoteEditorViewModel: ObservableObject {
    
    @Published var content: String
    @Published var selectedColor: NotePalette
    @Published var validationMessage: String?

    private var notePersistenceServicing: NotePersistenceService?

    let payload: NoteEditorPayload
    
    var screenTitle: String {
        payload.note == nil ? "New Note" : "Edit Note"
    }

    init(
        payload: NoteEditorPayload,
    
    ) {
        self.payload = payload

        self.content = payload.note?.content ?? ""
        self.selectedColor = NotePalette(rawValue:payload.note?.colorHex ?? NotePalette.ashGray.rawValue) ?? .ashGray

        
    }
    
    var isValid: Bool {
        !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
    }
    

    @discardableResult
    func save(onSave: (_ content: String, _ color: Int) -> Void) -> Bool {
        do {
            try validateInput( content: content)
            onSave(
                content.trimmingCharacters(in: .whitespacesAndNewlines),
                selectedColor.rawValue
                
            )
            return true
        } catch let error as NoteValidationError {
            validationMessage = error.localizedDescription
            return false
        } catch {
            validationMessage = "Couldn't save note."
            return false
        }
    }
    
    func validateInput(content: String) throws {

        
        if content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw NoteValidationError.emptyContent
        }
    }
    
    
  

}
