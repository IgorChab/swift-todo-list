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
    
    func selectCategory(_ category: Category) -> Void {
        if (selectedCategory == category) {
            selectedCategory = nil
        } else {
            selectedCategory = category
        }
    }
    
    func addTodo(title: String) {
        do {
            try realm.write {
                let todo = Todo(title: title, isChecked: false)
                realm.add(todo)
            }
        } catch let error {
            print("Failed to add todo in realm with error: \(error.localizedDescription)")
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
        
        for category in categories {
            print("📁 Категория: \(category.title), задач: \(category.todos.count)")
            for todo in category.todos {
                print("   • \(todo.title)")
            }
        }
        
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
        
        for todo in todos {
            if let category = todo.category {
                print("✅ \(todo.title) → категория: \(category.title)")
            } else {
                print("⚠️ \(todo.title) → категории нет (nil)")
            }
        }
        
        if let selectedCategory {
            print("in selectedCategory block")
            todos = todos.where {
                $0.category.id == selectedCategory.id
            }
        } else {
            print("in selectedCategory = nil block")
            todos = todos.where {
                $0.category == nil
            }
            print(todos.count)
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
