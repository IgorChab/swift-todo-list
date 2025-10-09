//
//  Todo.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 22.09.2025.
//

import Foundation
import RealmSwift

class Todo: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var isChecked: Bool
    @Persisted var category: Category?
    
    convenience init(title: String, isChecked: Bool, category: Category? = nil) {
        self.init()
        self.title = title
        self.isChecked = isChecked
        self.category = category
    }
}
