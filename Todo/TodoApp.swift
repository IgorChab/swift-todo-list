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
    let realm: Realm
    
    init() {
        func createRealm() -> Realm {
            var config = Realm.Configuration(
                schemaVersion: 1,
                deleteRealmIfMigrationNeeded: true
            )
            Realm.Configuration.defaultConfiguration = config
            config.objectTypes = [Category.self, Todo.self]
            config.deleteRealmIfMigrationNeeded = true
            let realm = try! Realm()
            return realm
        }
        
        realm = createRealm()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(viewModel: ContentViewModel(realm: realm))
                    .environment(\.realm, realm)
            }
        }
    }
}
