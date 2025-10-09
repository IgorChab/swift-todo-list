//
//  Category.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 22.09.2025.
//

import Foundation
import RealmSwift

class Category: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var icon: String
    @Persisted var color: String
    @Persisted var todos: List<Todo>
    
    convenience init(title: String, icon: String, color: String, todos: [Todo] = []) {
        self.init()
        self.title = title
        self.icon = icon
        self.color = color
        self.todos.append(objectsIn: todos)
        
        for todo in todos {
            todo.category = self
        }
    }
}
