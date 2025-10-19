//
//  AddCategoryModal.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 19.10.2025.
//

import SwiftUI

private let icons: [String] = [
    "message.fill",
    "suitcase.fill",
    "house.fill",
    "bookmark.fill",
    "heart.fill",
    "lightbulb.max.fill",
    "star.fill",
    "music.note",
    "airplane",
    "cart.fill"
]

private let colors: [String] = [
    "#98E2C6",
    "#FFE600",
    "#6270F0",
    "#52D22E",
    "#008148",
    "#E0607E",
    "#EF8A17",
    "#EF2917",
]

struct AddCategoryModal: View {
    @Binding var isVisible: Bool
    var isClosable: Bool = true
    let onSave: (String, String, String) -> Void
    @State private var title = ""
    @State private var selectedIcon: String?
    @State private var selectedColor: String?
    
    var isButtonDisabled: Bool {
        title.isEmpty || selectedIcon == nil || selectedColor == nil
    }
    
    private func clearModalState() {
        title = ""
        selectedIcon = nil
        selectedColor = nil
    }
    
    var body: some View {
        Modal(isVisible: $isVisible, isClosable: isClosable, onClose: clearModalState) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Add Category")
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
                
                LazyVGrid(
                    columns: [
                        GridItem(.adaptive(minimum: 40, maximum: 40), spacing: 10),
                        GridItem(.adaptive(minimum: 40, maximum: 40))
                    ],
                    spacing: 10
                ) {
                    ForEach(icons, id: \.self) { icon in
                        Button(action: {
                            withAnimation(.none) {
                                selectedIcon = icon
                            }
                        }) {
                            Image(systemName: icon)
                                .font(.system(size: 24))
                                .foregroundStyle(icon == selectedIcon ? .white : .black)
                                .background {
                                    RoundedRectangle(cornerRadius: 17)
                                        .fill(icon == selectedIcon ? .black : .white)
                                        .stroke(.black, lineWidth: 1)
                                        .frame(width: 40, height: 40)
                                }
                                .frame(width: 40, height: 40)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.bottom, 20)
                
                LazyVGrid(
                    columns: [
                        GridItem(.adaptive(minimum: 30, maximum: 30))
                    ],
                    spacing: 0
                ) {
                    ForEach(colors, id: \.self) { color in
                        Button(action: {
                            withAnimation(.none) {
                                selectedColor = color
                            }
                        }) {
                            Circle()
                                .fill(Color(hex: color))
                                .stroke(.black, lineWidth: selectedColor == color ? 1 : 0)
                                .frame(width: 30, height: 30)
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                Button(action: {
                    if let icon = selectedIcon, let color = selectedColor {
                        onSave(title, icon, color)
                        clearModalState()
                        isVisible = false
                    }
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
                .opacity(isButtonDisabled ? 0.5 : 1)
                .animation(.linear(duration: 0.2), value: isButtonDisabled)
                .disabled(isButtonDisabled)
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
        
        AddCategoryModal(isVisible: $isVisible, isClosable: true, onSave: { title, icon, color in
            print(title, icon, color)
        })
    }
}
