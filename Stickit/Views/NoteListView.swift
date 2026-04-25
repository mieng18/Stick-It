//
//  NoteListView.swift
//  Stickit
//
//  Created by Maisie Ng on 4/22/26.
//



import SwiftUI
import SwiftData


struct NoteListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @StateObject private var viewModel = NotesListViewModel()
    @Query private var notes: [Note]
    
    
    private var persistenceService: NotePersistenceService {
        NotePersistenceService(modelContext: modelContext)
    }
    
    var body: some View {
        
        NavigationStack{
            
            ZStack(alignment:.bottomTrailing)
            {
                VStack {
                    TopHeader
                    noteContent
                    
                }
                addNoteButton
            }
            
            .navigationDestination(item: $viewModel.editorPayload) { payload in

                NoteEditorView(payload: payload) { content, color in
                    viewModel.saveNote(payload: payload,content: content, color: color)

                }
                .navigationBarBackButtonHidden(true)
            }
            
        }
        
        .onAppear {
            viewModel.configure(modelContext: modelContext)
            viewModel.updateNotes(notes)
        }
        .onChange(of: notes) { _, latest in
            viewModel.updateNotes(latest)
        }
        
    }
    
    
    private var TopHeader: some View {
        
        HStack(spacing:8){
            Image("StickIt_Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 22
                )
            
            Spacer()
            controlMenu
            
        }
        
    }
    
    
    private var controlMenu: some View {
        Menu {
            Section("Layout"){
                Button{
                    
                } label: {
                    Label("List", systemImage: "list.bullet")
                    
                }
                
            }
            
        }label: {
            Image(systemName: "ellipsis.circle")
                .font(.title3)
        }
    }
    
    
    @ViewBuilder
    private var noteContent: some View {
        
        List {
            
            ForEach(notes) { note in
                noteCard(note)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                           
                            viewModel.deleteNote(note)

                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
       }
       .listStyle(.plain)

    }
    
    private func noteCard(_ note: Note) -> some View {
        NoteRowView(
            note: note
        )
        
    }
    
    var addNoteButton: some View {
        
        Button{
            
            viewModel.openNewNote()
            
        }label: {
            Image(systemName: "plus")
                .font(.title.bold())
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(
                    Circle()
                    .fill(Color.black)
                )
        }
    }
    
}



#Preview {
    NoteListView()
}
