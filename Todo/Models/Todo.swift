//
//  Todo.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 22.09.2025.
//

import Foundation
import SwiftData

@Model
class Todo: Identifiable {
    var id: UUID
    var title: String
    var isChecked: Bool
    var category: Category?
    
    init(id: UUID = UUID(), title: String, isChecked: Bool) {
        self.id = id
        self.title = title
        self.isChecked = isChecked
    }
}
