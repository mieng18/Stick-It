//
//  Note.swift
//  Stickit
//
//  Created by Maisie Ng on 4/22/26.
//

import Foundation
import SwiftData


@Model
final class Note{
    @Attribute(.unique) var id: UUID
    var content: String
    var timestamp: Date
    var updatedAt: Date
    var colorHex: Int
    var isPinned: Bool = false
    
    init(id: UUID = UUID(), content: String, timestamp: Date, updatedAt: Date,color:NotePalette, isPinned: Bool) {
        self.id = id
        self.content = content
        self.timestamp = timestamp
        self.updatedAt = updatedAt
        self.isPinned = isPinned
        self.colorHex = color.rawValue
    }
    
}


extension Note {
    
    var title: String {
        let lines = content
            .split(separator: "\n", omittingEmptySubsequences: true)
        
        return lines.first.map(String.init) ?? "Note"
    }
    
    var previewLine: String {
        let lines = content
            .split(separator: "\n", omittingEmptySubsequences: true)
        
        guard lines.count > 1 else { return "" }
        
        return lines.dropFirst().joined(separator: " ")
    }
}


enum NoteValidationError: LocalizedError {
    case emptyContent

    var errorDescription: String? {
        switch self {
     
        case .emptyContent:
            return "The content of the note can't be empty."
        }
    }
}



enum NoteSortMode: String, CaseIterable, Identifiable {
    case createNewest = "Date Created (Newest)"
    case createOldest = "Date Created (Oldest)"
    case editedNewest = "Date Edited (Newest)"
    case editedOldest = "Date Edited (Oldest)"
    
    var id: String {rawValue}
    
}

extension NoteSortMode {
    var userCreatedDate: Bool {
        switch self {
            case .createNewest, .createOldest: return true
        case .editedNewest,.editedOldest: return false
            
        }
    }
}

