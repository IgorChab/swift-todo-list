//
//  Checkbox.swift
//  Todo
//
//  Created by Чабанчук Игорь Романович on 12.10.2025.
//

import SwiftUI

struct Checkbox: View {
    let isChecked: Bool
    let onPress: () -> Void
    
    var body: some View {
        Button(action: onPress) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(isChecked ? Color(hex: "#95FA71", alpha: 0.37) : Color(hex: "#D9D9D9", alpha: 0.4))
                    .frame(width: 24, height: 24)

                if isChecked {
                    Image(systemName: "checkmark")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.green)
                }
            }
            // делаем label той же фиксированной размерности — это важно для hit-testing
            .frame(width: 24, height: 24)
        }
        .buttonStyle(.plain)
    }
}

#Preview() {
    Checkbox(isChecked: true, onPress: {})
}
