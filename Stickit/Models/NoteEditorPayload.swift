//
//  NoteEditorPayload.swift
//  Stickit
//
//  Created by Maisie Ng on 4/23/26.
//

import Foundation


struct NoteEditorPayload:Identifiable {
    var id = UUID()
    var note: Note?
}


extension NoteEditorPayload:Hashable {
    static func == (lhs:NoteEditorPayload,rhs:NoteEditorPayload) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
