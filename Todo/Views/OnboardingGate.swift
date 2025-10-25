//
//  OnboardingGate.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 25.10.2025.
//

import SwiftUI

struct OnboardingGate<Content: View>: View {
    @ViewBuilder var content: () -> Content
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some View {
        if (hasSeenOnboarding) {
            content()
        } else {
            OnboardingView()
        }
    }
}
