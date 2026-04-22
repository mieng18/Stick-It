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
    var title: String
    var content: String
    var timestamp: Date
    var updatedAt: Date
    var isPinned: Bool = false
    
    init(id: UUID, title: String, content: String, timestamp: Date, updatedAt: Date, isPinned: Bool) {
        self.id = id
        self.title = title
        self.content = content
        self.timestamp = timestamp
        self.updatedAt = updatedAt
        self.isPinned = isPinned
    }
    
}
