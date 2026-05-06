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
                        .padding(.top,24
                        )
                    
                }
                addNoteButton
                    .padding(.horizontal,16
                    )
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
                .frame(height: 25
                )
            
            Spacer()
            controlMenu
            
        }
        .padding(.horizontal,16)
        .safeAreaPadding(.top)
        
    }
    
    
    private var controlMenu: some View {
        Menu {
            Section("Layout"){
                Button{
                    
                } label: {
                    Label("List", systemImage: "list.bullet")
                    
                }
                
            }
            
            Section("Sort By") {
                ForEach(NoteSortMode.allCases) { mode in
                    Button {
                        
                        viewModel.setSortMode(mode)

                        
                    } label: {
                        Label(mode.rawValue,systemImage: viewModel.sortMode == mode ?
                              "checkmark.circle.fill" : ""
                        )
                        .font(.caption)
                    }
                }
            }
            
        }label: {
            Image(systemName: "ellipsis.circle")
                .font(.title3)
                .foregroundColor(.black.opacity(0.8))

            
          
        }
    }
    
    
    @ViewBuilder
    private var noteContent: some View {
        
        List {
            Section {
                if viewModel.showsPinnedNotes {
                    ForEach(viewModel.pinnedNote) { note in
                        noteCard(note)
                    }
                }
            } header: {
                if !viewModel.pinnedNote.isEmpty {
                    Button {
                        withAnimation(.easeInOut) {
                            viewModel.togglePinnedNotesVisibility()
                        }
                    } label: {
                        HStack {
                            Text("Pinned")

                            Spacer()

                            Image(
                                systemName: viewModel.showsPinnedNotes
                                ? "chevron.down"
                                : "chevron.right"
                            )
                        }
                    }
                    .buttonStyle(.plain)
                    .textCase(nil)
                }
            }
            
           
            
            if !viewModel.regularNotes.isEmpty{
                ForEach(viewModel.regularNotes) { note in
                    noteCard(note)
                        
                }
            }
                
              
        }
        .listStyle(.plain)

    }
    
    private func noteCard(_ note: Note) -> some View {
        NoteRowView(
            note: note,
            sortMode: viewModel.sortMode
        )
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(

           EdgeInsets(

               top: 0,

               leading: 12,

               bottom: 8,

               trailing: 12

           )

        )
        
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive) {
               
                viewModel.deleteNote(note)

            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .onTapGesture {
            viewModel.openEditor(for: note)
        }
        .contextMenu {
            Button(note.isPinned ? "Unpin" : "Pin") {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                    viewModel.togglePinned(note)

                }
                Button("Delete", role: .destructive) {
                    viewModel.deleteNote(note)

                }
            }
              
        }
        
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
