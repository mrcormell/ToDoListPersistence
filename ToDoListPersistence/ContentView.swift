//
//  ContentView.swift
//  ToDoListPersistence
//
//  Created by Cormell, David - DPC on 28/02/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isDarkMode: Bool = false
    @State private var showingAddSheet: Bool = false
    @State private var todos: [String] = ["Pick up dry cleaning", "Book an online groceries delivery", "File tax return"]
    @State private var newTodo = ""
    
    var body: some View {
        NavigationStack {
            List(todos, id: \.self) { todo in
                Text(todo)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Add", systemImage: "plus") {
                        showingAddSheet = true
                    }
                })
            }
            .popover(isPresented: $showingAddSheet) {
                Form {
                    TextField("Add new ToDo", text: $newTodo)
                    Button("Add") {
                        todos.append(newTodo)
                        newTodo = ""
                        showingAddSheet = false
                    }
                }
            }
            Toggle("Dark Mode", isOn: $isDarkMode)
                .padding()
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)

    }
}

#Preview {
    ContentView()
}
