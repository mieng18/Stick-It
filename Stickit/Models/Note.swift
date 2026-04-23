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
    var isPinned: Bool = false
    
    init(id: UUID, content: String, timestamp: Date, updatedAt: Date, isPinned: Bool) {
        self.id = id
        self.content = content
        self.timestamp = timestamp
        self.updatedAt = updatedAt
        self.isPinned = isPinned
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
