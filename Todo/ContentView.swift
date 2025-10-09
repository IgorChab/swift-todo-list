//
//  ContentView.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 29.06.2025.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State private var title = ""
    @State private var isShowCompleted = false
    
    @Environment(\.realm) private var realm
    @StateObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Home").font(.title).bold()
                Spacer()
                Circle().frame(width: 32, height: 32).foregroundStyle(.blue)
            }
            .padding(.horizontal, 16)
            
            TabBar(isShowCompleted: $isShowCompleted)
                .padding(.horizontal, 16)
            
            HStack {
                Text("Categories")
                    .font(.title3)
                    .bold()
                Spacer()
                Button("Add", action: {})
                    .frame(height: 30)
                    .padding(.horizontal, 12)
                    .background(.black)
                    .cornerRadius(100)
                    .bold()
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(viewModel.categories) { category in
                        CategoryView(
                            category: category,
                            isActive: viewModel.selectedCategory == category,
                            onPress: {
                                viewModel.selectCategory(category)
                            }
                        )
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.topLeading)
    
        ForEach(viewModel.todos) { todo in
            Text(todo.title)
        }
        TextField("Title", text: $title)
        Button("add todo", action: {
            viewModel.addTodo(title: title)
            title = ""
        })
    }
}

#Preview() {
    let realm = InMemoryRealmProvider.make(identifier: "HomeScreen")
    Category.createSampleData(in: realm)
    return ContentView(viewModel: ContentViewModel(realm: realm))
        .environment(\.realm, realm)
}
