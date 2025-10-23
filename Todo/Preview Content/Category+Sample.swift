//
//  Category+Sample.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 23.09.2025.
//

import RealmSwift

extension Category {
    static let sampleData = [
        Category(title: "Work", icon: "suitcase.fill", color: "#6270F0"),
        Category(title: "Home", icon: "house.fill", color: "#FFE600"),
        Category(title: "Sport", icon: "heart.fill", color: "#52D22E")
    ]
    
    static func createSampleData(in realm: Realm) {
        try! realm.write {
            realm.add(sampleData)
        }
    }
}
