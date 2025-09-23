//
//  ContentView.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 29.06.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var title = ""
    
    @Environment(\.modelContext) private var context
    @Query() var categories: [Category]
    @Query(filter: #Predicate<Todo> { $0.category == nil }) var todos: [Todo]
    
    var body: some View {
        VStack() {
            HStack {
                Text("Home").font(.title).bold()
                Spacer()
                Circle().frame(width: 32, height: 32).foregroundStyle(.blue)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.topLeading)
        .padding(.horizontal, 16)
//        ForEach(categories) { category in
//            Text(category.title).background(Color(hex: category.color))
//        }
//        ForEach(todos) { todo in
//            Text(todo.title)
//        }
//        TextField("Title", text: $title)
//        Image(systemName: "house.fill")
//        Button("add todo") {
//            context.insert(Todo(title: title, isChecked: false))
//        }
    }
}

#Preview(traits: .categorySampleData) {
    ContentView()
}
