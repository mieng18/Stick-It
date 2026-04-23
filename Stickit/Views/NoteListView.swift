//
//  NoteListView.swift
//  Stickit
//
//  Created by Maisie Ng on 4/22/26.
//



import SwiftUI


struct NoteListView: View {
    
    @StateObject var viewModel = NotesListViewModel()
    
    
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
                NoteEditorView(payload: payload)
                
            }
            
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
        ScrollView{
            LazyVStack{
                ForEach(viewModel.notes) {
                    note in
                    noteCard(note)
                }
            }
        }
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
