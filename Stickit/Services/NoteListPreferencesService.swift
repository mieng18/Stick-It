//
//  NoteListPreferencesService.swift
//  Stickit
//
//  Created by Maisie Ng on 5/5/26.
//

import Foundation



protocol NoteListPreferencesServicing{
    var sortMode: NoteSortMode {get set}
    var showsPinnedNotes: Bool { get set }
}
final class NoteListPreferencesService: NoteListPreferencesServicing {
    

    private enum Keys {
        static let sortMode = "stickit.sort_mode"
        static let showsPinnedNotes = "stickit.shows_pinned_notes"
    }
    
    private let userDefault: UserDefaults
    
    init(userDefault: UserDefaults = .standard) {
        self.userDefault = userDefault
    }
    
    
    var sortMode: NoteSortMode {
        get {
            let rawValue = userDefault.string(forKey: Keys.sortMode) ?? NoteSortMode.editedNewest.rawValue
            return NoteSortMode(rawValue: rawValue) ?? .editedNewest
        }
        set {
            userDefault.set(newValue.rawValue, forKey:  Keys.sortMode)
        }
    }
    
    var showsPinnedNotes: Bool {

        get {
            userDefault.object(forKey: Keys.showsPinnedNotes) as? Bool ?? true
        }

        set {
            userDefault.set(newValue, forKey: Keys.showsPinnedNotes)

        }

    }
}
