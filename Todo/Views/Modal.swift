//
//  Modal.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 14.10.2025.
//

protocol ModalProps {
    var isVisible: Bool { get set }
    var isClosable: Bool { get }
}

import SwiftUI

struct Modal<Content: View>: View, ModalProps {
    @Binding var isVisible: Bool
    let isClosable: Bool
    @ViewBuilder var content: () -> Content
    @State private var offsetY: CGFloat = 1000
    @State private var opacity: Double = 0
    
    func closeModal() {
        withAnimation {
            offsetY = 1000
            opacity = 0
            isVisible = false
        }
    }
    
    func openModal() {
        withAnimation(.spring(bounce: 0.2)) {
            offsetY = 0
            opacity = 0.3
        }
    }
    
    var body: some View {
        ZStack {
            Color(.black).opacity(opacity)
                .onTapGesture(perform: {
                    print("tap on bg")
                    closeModal()
                })
            
            VStack(alignment: .leading) {
                content()
            }
            .padding(.top, 40)
            .padding([.horizontal, .bottom])
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 20).fill(.white)
                    if (isClosable) {
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "xmark")
                                    .onTapGesture(perform: closeModal)
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .offset(x: 0, y: offsetY)
        }
        .ignoresSafeArea()
        .onChange(of: isVisible) {
            if (isVisible) {
                openModal()
            } else {
                closeModal()
            }
        }
        .onAppear {
            if (isVisible) {
                openModal()
            } else {
                closeModal()
            }
        }
    }
}

#Preview {
    @Previewable @State var isVisible = false
    
    ZStack {
        Button("toggle modal") {
            isVisible = !isVisible
        }
        
        Modal(isVisible: $isVisible, isClosable: true) {
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 10)
                
                Text("Description")
                    .font(.body)
            }
            .frame(width: 200, height: 100, alignment: .topLeading)
        }
    }
}
