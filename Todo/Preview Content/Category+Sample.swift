//
//  Category+Sample.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 23.09.2025.
//

extension Category {
    static let sampleData = [
        Category(title: "Work", icon: "suitcase.fill", color: "#6270F0", todos: [
            Todo(title: "Do work", isChecked: false),
            Todo(title: "Do some tasks", isChecked: false),
        ]),
        Category(title: "Home", icon: "house.fill", color: "#FFE600", todos: [
            Todo(title: "Rest after work", isChecked: false),
            Todo(title: "Clean room", isChecked: false),
        ]),
        Category(title: "Sport", icon: "heart.fill", color: "#52D22E", todos: [
            Todo(title: "Run", isChecked: false),
            Todo(title: "Train", isChecked: false),
        ])
    ]
}
