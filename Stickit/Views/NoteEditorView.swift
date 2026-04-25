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

    
    let onSave: (_ content: String, _ color: Int) -> Void

    
    init(payload: NoteEditorPayload, onSave:  @escaping (_ content: String, _ color: Int) -> Void) {
        
        self.onSave = onSave

        _viewModel = StateObject(wrappedValue: NoteEditorViewModel(payload: payload))
        
    }
    var body: some View {
        
        ZStack{
            Color(hex: viewModel.selectedColor.rawValue)
                .ignoresSafeArea()
            
            VStack {
                topBar
                    .padding(.bottom,20)
                atmosphereSection
                ScrollView{
                    VStack(alignment: .leading,spacing: 0){
                        contentSection
                    }
                }
            }
            .padding(.horizontal, 18)

        }
    }
    
    
    private var topBar: some View {
        HStack {
            Button("Cancel"){
                dismiss()
            }
            .font(.system(size:16,weight: .regular,design: .default))
            .foregroundStyle(.secondary)
            
            Spacer()
            Text(viewModel.screenTitle)
            
            Spacer()
            Button("Save"){
                
                if viewModel.save(onSave: onSave) {
                    dismiss()
                }
            }
            .font(.system(size:16,weight: .regular,design: .default))
            .foregroundStyle(.secondary)

            
        }
    }
    
    
    private var atmosphereSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(NotePalette.allCases) { noteColor in
                        VStack{
                            ColorCircleView(
                                noteColor: noteColor,
                                isSelected: viewModel.selectedColor == noteColor
                            ) {
                                
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    viewModel.selectedColor = noteColor

                                }
                            }
                            
                            Circle()
                                .fill( viewModel.selectedColor == noteColor ? Color.secondary : Color.clear)
                                .frame(width: 6, height: 6)

                        }
                    }
                }
                .padding(.vertical, 2)
                .padding(.trailing, 6)
            }
        }
    }
    struct ColorCircleView: View {
        let noteColor: NotePalette
        let isSelected: Bool
        let onTap: () -> Void
        
        var body: some View {
            Circle()
                .fill(noteColor.color)
                .frame(width: 32, height: 32)
                .overlay(
                    Circle().stroke(Color.white.opacity(0.8), lineWidth: 3)
                )
                .onTapGesture {
                    onTap()
                }
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


