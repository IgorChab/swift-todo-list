//
//  TodoApp.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 29.06.2025.
//

import SwiftUI
import SwiftData

@main
struct TodoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            Todo.self,
            Category.self
        ], isAutosaveEnabled: true)
    }
}
