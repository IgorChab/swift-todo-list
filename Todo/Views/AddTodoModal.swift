//
//  AddTodoModal.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 18.10.2025.
//

import SwiftUI

struct AddTodoModal: View {
    @Binding var isVisible: Bool
    var isClosable: Bool = true
    let onSave: (_ title: String) -> Void
    @State private var title = ""
    @State private var category = ""
    
    var body: some View {
        Modal(isVisible: $isVisible, isClosable: isClosable) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Add Task")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 20)
                
                Text("Title").foregroundStyle(Color(hex: "#757575"))
                    .padding(.bottom, 8)
                TextField("", text: $title)
                    .padding(.horizontal, 12)
                    .frame(height: 52)
                    .background(Color(hex: "#EAEAEA"))
                    .cornerRadius(8)
                    .tint(Color(hex: "#757575"))
                    .padding(.bottom, 20)
                    .autocorrectionDisabled()
                
                Text("Category").foregroundStyle(Color(hex: "#757575"))
                    .padding(.bottom, 8)
                TextField("", text: $category)
                    .padding(.horizontal, 12)
                    .frame(height: 52)
                    .background(Color(hex: "#EAEAEA"))
                    .cornerRadius(8)
                    .tint(Color(hex: "#757575"))
                
                Button(action: {
                    onSave(title)
                    title = ""
                    isVisible = false
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.white)
                }
                .background(.black)
                .cornerRadius(100)
                .padding(.top, 20)
                .opacity(title.isEmpty ? 0.5 : 1)
                .animation(.linear(duration: 0.2), value: title)
                .disabled(title.isEmpty)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
    }
}

#Preview {
    @Previewable @State var isVisible = true
    
    ZStack {
        Button("toggle modal") {
            isVisible = !isVisible
        }
        
        AddTodoModal(isVisible: $isVisible, isClosable: true, onSave: {title in })
    }
}
