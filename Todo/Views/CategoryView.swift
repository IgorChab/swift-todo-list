//
//  CategoryView.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 26.09.2025.
//

import SwiftUI

struct CategoryView: View {
    let category: Category
    let isActive: Bool
    
    var tasksCountTitle: String {
        let correctNumber = category.todos.count < 10 ? "0\(category.todos.count)" : "\(category.todos.count)"
        return "+\(correctNumber) task"
    }
    
    var body: some View {
        UnevenRoundedRectangle(topLeadingRadius: 23, bottomLeadingRadius: 23, bottomTrailingRadius: 23, topTrailingRadius: 63)
            .fill(Color(hex: category.color, alpha: 0.3))
            .stroke(.white, lineWidth: 2)
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Circle()
                            .fill(.white)
                            .stroke(Color(hex: category.color), lineWidth: 1)
                            .frame(width: 51, height: 51)
                            .shadow(color: Color(hex: category.color, alpha: 0.3), radius: 20, x: 0, y: 14)
                            .overlay {
                                Image(systemName: category.icon).foregroundStyle(Color(hex: category.color))
                            }
                            .padding(.bottom, 12)
                        
                        Text(category.title).font(.title3).bold()
                        
                        Text(tasksCountTitle).font(.callout).foregroundStyle(Color(hex: "#757575"))
                    }
                    .padding(.leading, 9)
                    .padding(.top, 11)
                    
                    Spacer()
                    
                    if isActive {
                        VStack(alignment: .center) {
                            UnevenRoundedRectangle(topLeadingRadius: 15, topTrailingRadius: 15)
                                .fill(Color(hex: category.color))
                                .frame(width: 71, height: 5)
                                .offset(y: 1)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .shadow(color: Color(hex: category.color, alpha: 0.3), radius: 10, x: 0, y: 0)
            .frame(width: 112, height: 136)
    }
}

#Preview {
    CategoryView(category: Category.sampleData[0], isActive: true)
}
