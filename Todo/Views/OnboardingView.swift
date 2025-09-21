//
//  OnboardingView.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 29.06.2025.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack {
            Image("Decorative")
                .padding(.nan)
            
            VStack(spacing: 16) {
                Spacer()
                Text("Plan your Day in Details")
                    .font(.title)
                    .bold()
                Text("There are many variations of passagesThere are many variations.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                
                Circle()
                    .strokeBorder(.gray, lineWidth: 1)
                    .frame(width: 84)
                    .overlay() {
                        Circle()
                            .frame(width: 66)
                            .overlay() {
                                Image("ArrowRight")
                            }
                    }.frame(height: 84)
            }
            .padding(.bottom, 150)
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#FFFCE3"))
    }
}

#Preview {
    OnboardingView()
}
