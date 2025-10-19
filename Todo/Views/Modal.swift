//
//  Modal.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 14.10.2025.
//

import SwiftUI

struct Modal<Content: View>: View {
    @Binding var isVisible: Bool
    let isClosable: Bool
    var onClose: (() -> Void)?
    @ViewBuilder var content: () -> Content
    @State private var offsetY: CGFloat = 1000
    @State private var opacity: Double = 0
    
    func closeModal() {
        isVisible = false
        
        if let onClose {
            onClose()
        }
    }
    
    func runCloseAnimation() {
        withAnimation {
            offsetY = 1000
            opacity = 0
        }
    }
    
    func runOpenAnimation() {
        withAnimation(.spring(bounce: 0.2)) {
            offsetY = 0
            opacity = 0.3
        }
    }
    
    var body: some View {
        ZStack {
            Color(.black).opacity(opacity)
                .onTapGesture(perform: {
                    closeModal()
                })
            
            content()
            .padding(.top, 50)
            .padding([.horizontal, .bottom])
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 20).fill(.white)
                    if (isClosable) {
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "xmark")
                                    .font(.system(size: 24))
                                    .onTapGesture(perform: closeModal)
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .padding()
            .offset(x: 0, y: offsetY)
        }
        .ignoresSafeArea()
        .onChange(of: isVisible) {
            if (isVisible) {
                runOpenAnimation()
            } else {
                runCloseAnimation()
            }
        }
        .onAppear {
            if (isVisible) {
                runOpenAnimation()
            } else {
                runCloseAnimation()
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
        
        Modal(isVisible: $isVisible, isClosable: true, onClose: { print("onClose") }) {
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
