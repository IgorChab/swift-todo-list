//
//  ContentViewModel.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 05.10.2025.
//

import SwiftUI
import RealmSwift

class ContentViewModel: ObservableObject {
    private let realm: Realm
    private var categoriesToken: NotificationToken?
    private var todoaToken: NotificationToken?
    
    @Published var categories: [Category] = []
    @Published var todos: [Todo] = []
    @Published var selectedCategory: Category? {
        didSet {
            observeTodos()
        }
    }
    
    @Published var isShowCompleted = false {
        didSet {
            observeTodos()
        }
    }
    
    func selectAllTasks() {
        do {
            try realm.write {
                todos.forEach({
                    $0.isChecked = true
                })
            }
        } catch let error {
            print("Failed to select all tasks in realm with error: \(error.localizedDescription)")
        }
    }
    
    func selectCategory(_ category: Category) -> Void {
        if (selectedCategory == category) {
            selectedCategory = nil
        } else {
            selectedCategory = category
        }
    }
    
    func createCategory(title: String, icon: String, color: String) {
        do {
            try realm.write {
                let category = Category(title: title, icon: icon, color: color)
                realm.add(category)
            }
        } catch let error {
            print("Failed to create category in realm with error: \(error.localizedDescription)")
        }
    }
    
    func addTodo(title: String, category: Category?) {
        do {
            try realm.write {
                let todo = Todo(title: title, isChecked: false, category: nil)
                
                if let category {
                    let localCategory = realm.create(Category.self, value: category, update: .modified)
                    todo.category = localCategory
                }
                
                
                realm.add(todo)
            }
            
            observeTodos()
        } catch let error {
            print("Failed to add todo in realm with error: \(error.localizedDescription)")
        }
    }
    
    func toggleCheckedTodo(_ todo: Todo) {
        do {
            try realm.write {
                todo.isChecked = !todo.isChecked
            }
        } catch let error {
            print("Failed to add todo in realm with error: \(error.localizedDescription)")
        }
    }
    
    func deleteTodo(_ todo: Todo) {
        do {
            self.todos = self.todos.filter { $0 != todo }
            try realm.write {
                realm.delete(todo)
            }
        } catch let error {
            print("Failed to delete todo in realm with error: \(error.localizedDescription)")
        }
    }
    
    init(realm: Realm) {
        self.realm = realm
        observeCategories()
        observeTodos()
    }
    
    private func observeCategories() {
        categoriesToken?.invalidate()
        
        let categories = realm.objects(Category.self)
        
        categoriesToken = categories.observe { [weak self] changes in
            switch changes {
                case .initial(let collection),
                     .update(let collection, _, _, _):
                    self?.categories = Array(collection)
                case .error(let error):
                    print(error)
            }
        }
    }
    
    private func observeTodos() {
        todoaToken?.invalidate()
        
        var todos = realm.objects(Todo.self)
        
        if isShowCompleted == true {
            todos = todos.where { $0.isChecked == isShowCompleted }
        }
        
        if let selectedCategory {
            todos = todos.where {
                $0.category.id == selectedCategory.id
            }
        } else {
            todos = todos.where {
                $0.category == nil
            }
        }
        
        todoaToken = todos.observe { [weak self] changes in
            switch changes {
                case .initial(let collection),
                     .update(let collection, _, _, _):
                    self?.todos = Array(collection)
                case .error(let error):
                    print(error)
            }
        }
    }
    
    deinit {
        categoriesToken?.invalidate()
        todoaToken?.invalidate()
    }
}
