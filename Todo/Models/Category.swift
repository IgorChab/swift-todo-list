//
//  Category.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 22.09.2025.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Category: Identifiable {
    var id: UUID
    var title: String
    var icon: String
    var color: String
    
    @Relationship(deleteRule: .cascade, inverse: \Todo.category)
    var todos: [Todo]
    
    init(id: UUID = UUID(), title: String, icon: String, color: String, todos: [Todo]) {
        self.id = id
        self.title = title
        self.icon = icon
        self.color = color
        self.todos = todos
    }
}
