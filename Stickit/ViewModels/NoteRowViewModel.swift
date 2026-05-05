//
//  NoteRowViewModel.swift
//  Stickit
//
//  Created by Maisie Ng on 4/22/26.
//

import Foundation
import SwiftUI


struct NoteRowViewModel{
    let note: Note
    let sortMode: NoteSortMode

    var displayDate: Date {
        sortMode.userCreatedDate ? note.timestamp : note.updatedAt
    }
     
}
