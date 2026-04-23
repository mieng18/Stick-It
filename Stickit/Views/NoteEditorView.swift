//
//  NoteEditorView.swift
//  Stickit
//
//  Created by Maisie Ng on 4/23/26.
//

import Foundation
import SwiftUI



struct NoteEditorView:View{
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: NoteEditorViewModel

    
    init(payload: NoteEditorPayload) {
            _viewModel = StateObject(wrappedValue: NoteEditorViewModel(payload: payload))
        }
    var body: some View {
        
        ZStack{
            VStack {
                ScrollView{
                    VStack(alignment: .leading,spacing: 0){
                        contentSection
                    }
                }
            }
            .padding(.horizontal, 18)

        }
    }
    
    private var contentSection: some View {
        ZStack(alignment: .topLeading) {
            
            if viewModel.content.isEmpty {
                HStack{
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                    
                        .foregroundStyle(Color.black.opacity(0.3))
                    
                    Text("Start writing...")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(Color.black.opacity(0.24))
                        .padding(.top, 8)
                        .padding(.leading, 6)
                        .allowsHitTesting(false)
                }
            }
            
            
            TextEditor(text: $viewModel.content)
                .font(.system(size: 20))
                .scrollContentBackground(.hidden)
                .foregroundStyle(Color.black.opacity(0.72))

        }
    }

}


