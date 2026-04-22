//
//  NoteRowView.swift
//  Stickit
//
//  Created by Maisie Ng on 4/22/26.
//

import Foundation
import SwiftUI


struct NoteRowView: View {
    let note: Note
    
    private var viewModel: NoteRowViewModel{NoteRowViewModel(note: note)}
    
    var body: some View {
        VStack(alignment: .leading,spacing: 4){
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.8))
                    .frame(maxWidth: .infinity)
                
                FoldedCorner()
                    .fill(Color.black.opacity(0.12))
                    .frame(width: 44, height: 44)
            }
            .overlay(alignment: .leading) {
                VStack(alignment: .leading,spacing: 8) {
                    Text(note.title)
                        .font(.headline)
                        .lineLimit(1)
                    Text(note.content)
                        .font(.footnote)
                        .lineLimit(2 )
                        .foregroundStyle(.secondary)
                    
                    Text("\(viewModel.displayDate, format: Date.FormatStyle(date: .abbreviated, time: .shortened))")
                        .font(.caption2)
                        .foregroundStyle(.secondary)

                }
                .padding(16)
            }
            .frame(minHeight: 120)
            
        }
        
    }
}



private struct FoldedCorner: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}
