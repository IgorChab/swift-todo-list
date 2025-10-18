//
//  Todo+Sample.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 22.09.2025.
//

import Foundation
import RealmSwift

extension Todo {
    static let sampleData = [
        Todo(title: "Learn swift", isChecked: true),
        Todo(title: "Do work", isChecked: false),
        Todo(title: "Sleap", isChecked: false),
    ]
    
    static func createSampleData(in realm: Realm) {
        try! realm.write {
            realm.add(sampleData)
        }
    }
}
