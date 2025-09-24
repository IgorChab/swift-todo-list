//
//  TabBar.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 24.09.2025.
//

import SwiftUI

struct TabBar: View {
    @Binding var isShowCompleted: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .frame(maxWidth: .infinity)
                .cornerRadius(100)
                .overlay(alignment: .leading) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: geometry.size.width * 0.4, height: 43)
                            .cornerRadius(100)
                            .foregroundStyle(.white)
                            .offset(x: isShowCompleted == false ? 0 : geometry.size.width - geometry.size.width * 0.4 - 20)
                            .animation(.easeInOut(duration: 0.3), value: isShowCompleted)
                        
                        HStack {
                            Button(action: { isShowCompleted = false }) {
                                Text("Task List")
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(isShowCompleted ? .white : .black)
                                    .frame(width: geometry.size.width * 0.4)
                                    .animation(.linear(duration: 0.3), value: isShowCompleted)
                            }
                            
                            Spacer()
                            
                            Button(action: { isShowCompleted = true }) {
                                Text("Completed")
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(isShowCompleted ? .black : .white)
                                    .frame(width: geometry.size.width * 0.4)
                                    .animation(.linear(duration: 0.3), value: isShowCompleted)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
        }
        .frame(maxHeight: 60)
    }
}

#Preview {
    @Previewable @State var isShowCompleted = false
    TabBar(isShowCompleted: $isShowCompleted)
}
