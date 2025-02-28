//
//  ContentView.swift
//  ToDoListPersistence
//
//  Created by Cormell, David - DPC on 28/02/2025.
//

import SwiftUI

let darkModeKey = "DarkMode"

struct ContentView: View {
    @State private var isDarkMode: Bool = UserDefaults.standard.bool(forKey: darkModeKey)
    @State private var showingAddSheet: Bool = false
    @State private var todos: [String] = UserDefaults.standard.object(forKey: "ToDoList") as? [String] ?? [String]()
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
                        UserDefaults.standard.set(todos, forKey: "ToDoList")
                    }
                }
            }
            Toggle("Dark Mode", isOn: $isDarkMode)
                .onChange(of: isDarkMode) {
                    UserDefaults.standard.set(isDarkMode, forKey: darkModeKey)
                }
                .padding()
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)

    }
}

#Preview {
    ContentView()
}
