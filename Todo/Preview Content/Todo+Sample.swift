//
//  Todo+Sample.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 22.09.2025.
//

import Foundation
import RealmSwift

extension Todo {
    static func createSampleData(in realm: Realm) {
        try! realm.write {
            let sampleData = [
                Todo(title: "Learn swift", isChecked: true),
                Todo(title: "Do work", isChecked: false),
                Todo(title: "Sleap", isChecked: false),
            ]
            
            realm.add(sampleData)
        }
    }
}
