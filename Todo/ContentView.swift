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
    @State private var isModalVisible = false
    
    @Environment(\.realm) private var realm
    @StateObject var viewModel: ContentViewModel
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Home").font(.title).bold()
                    Spacer()
                    Circle().frame(width: 32, height: 32).foregroundStyle(.blue)
                }
                .padding(.horizontal, 16)
                
                TabBar(isShowCompleted: $viewModel.isShowCompleted)
                    .padding(.horizontal, 16)
                
                HStack {
                    Text("Categories")
                        .font(.title3)
                        .bold()
                    Spacer()
                    Button(action: {}) {
                        Text("Add")
                            .frame(height: 30)
                            .padding(.horizontal, 12)
                    }
                        .background(.black)
                        .cornerRadius(100)
                        .bold()
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                
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
                
                UnevenRoundedRectangle(cornerRadii: .init(topLeading: 45, topTrailing: 45))
                    .fill(Color(hex: "#FAFAFA"))
                    .ignoresSafeArea()
                    .overlay(alignment: .topLeading) {
                        VStack {
                            HStack {
                                Text("Task List")
                                    .font(.title2)
                                    .bold()
                                
                                Spacer()
                                
                                Button(action: {
                                    isModalVisible = true
                                }) {
                                    Text("Add Task")
                                        .frame(height: 43)
                                        .padding(.horizontal, 24)
                                }
                                .background(.black)
                                .cornerRadius(100)
                                .font(.title3)
                                .bold()
                                .foregroundStyle(.white)
                            }
                            .padding(.vertical, 24)
                            .padding(.horizontal, 20)
                            
                            Divider()
                                .frame(height: 1).background(Color(hex: "#FAFAFA"))
                                .padding(.horizontal, 20)
                            
                            List {
                                ForEach(viewModel.todos) { todo in
                                    HStack {
                                        Text(todo.title)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Spacer()
                                        
                                        Checkbox(isChecked: todo.isChecked, onPress: {
                                            viewModel.toggleCheckedTodo(todo)
                                        })
                                    }
                                    .padding(.horizontal, 20)
                                    .frame(height: 57)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(.white)
                                    )
                                    .listRowInsets(EdgeInsets())
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                                }
                                .onDelete(perform: { indices in
                                    let todosToDelete = indices.map { viewModel.todos[$0] }
                                    viewModel.deleteTodo(todosToDelete[0])
                                })
                                .padding(.horizontal, 20)
                            }
                            .listRowSpacing(16)
                            .listStyle(.plain)
                            .scrollContentBackground(.hidden)
                            .background(.clear)
                        }
                    }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.topLeading)
            
            AddTodoModal(isVisible: $isModalVisible) { title in
                viewModel.addTodo(title: title)
            }
        }
    }
}

#Preview() {
    let realm = InMemoryRealmProvider.make(identifier: "HomeScreen")
    Category.createSampleData(in: realm)
    return NavigationStack {
        ContentView(viewModel: ContentViewModel(realm: realm))
            .environment(\.realm, realm)
    }
}
