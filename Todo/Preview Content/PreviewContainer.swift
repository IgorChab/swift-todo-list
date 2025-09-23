//
//  PreviewContainer.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 22.09.2025.
//

import SwiftUI
import SwiftData

struct TodoSampleData: PreviewModifier {
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(for: Todo.self, Category.self, configurations: .init(isStoredInMemoryOnly: true))
        Todo.sampleData.forEach { todo in
            container.mainContext.insert(todo)
        }
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var todoSampleData: Self = .modifier(TodoSampleData())
}



struct CategorySampleData: PreviewModifier {
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(for: Todo.self, Category.self, configurations: .init(isStoredInMemoryOnly: true))
        Category.sampleData.forEach { category in
            container.mainContext.insert(category)
        }
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var categorySampleData: Self = .modifier(CategorySampleData())
}
