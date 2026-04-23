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


    let payload: NoteEditorPayload

    init(
        payload: NoteEditorPayload,
    
    ) {
        self.payload = payload

        self.content = payload.note?.content ?? ""
        
    }

}
