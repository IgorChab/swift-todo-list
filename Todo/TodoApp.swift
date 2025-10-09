//
//  TodoApp.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 29.06.2025.
//

import SwiftUI
import RealmSwift

@main
struct TodoApp: App {
    init() {
        let config = Realm.Configuration(
            schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // можно добавить обработку при необходимости
                }
            }, deleteRealmIfMigrationNeeded: true
        )
        Realm.Configuration.defaultConfiguration = config
        if let realmURL = Realm.Configuration.defaultConfiguration.fileURL {
            try? FileManager.default.removeItem(at: realmURL)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(realm: try! Realm()))
        }
    }
}
