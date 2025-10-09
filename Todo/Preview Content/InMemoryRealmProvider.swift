//
//  InMemoryRealmProvider.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 05.10.2025.
//

import Foundation
import RealmSwift

@MainActor
struct InMemoryRealmProvider {
    static func make(identifier: String = UUID().uuidString) -> Realm {
        var config = Realm.Configuration(inMemoryIdentifier: identifier)
        config.objectTypes = [Category.self, Todo.self]
        config.deleteRealmIfMigrationNeeded = true
        if let realmURL = Realm.Configuration.defaultConfiguration.fileURL {
            try? FileManager.default.removeItem(at: realmURL)
        }
        return try! Realm(configuration: config)
    }
}
