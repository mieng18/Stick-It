//
//  NoteListPreferencesService.swift
//  Stickit
//
//  Created by Maisie Ng on 5/5/26.
//

import Foundation



protocol NoteListDisplayConfigurable{
    var sortMode: NoteSortMode {get set}
}
final class NoteListPreferencesService: NoteListDisplayConfigurable {
    

    private enum Keys {
        static let sortMode = "stickit.sort_mode"
    }
    
    private let userDefault: UserDefaults
    
    init(userDefault: UserDefaults = .standard) {
        self.userDefault = userDefault
    }
    
    
    var sortMode: NoteSortMode {
        get  {
            let rawValue = userDefault.string(forKey: Keys.sortMode) ?? NoteSortMode.editedNewest.rawValue
            return NoteSortMode(rawValue: rawValue) ?? .editedNewest
        }
        set {
            userDefault.set(newValue.rawValue, forKey:  Keys.sortMode)
        }
    }
    
    
}
