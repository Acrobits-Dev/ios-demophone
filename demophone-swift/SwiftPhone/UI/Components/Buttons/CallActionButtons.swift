//
//  CallActionButtons.swift
//  SwiftPhone
//
//  Created by Diego on 14.01.2025.
//  Copyright © 2025 Acrobits. All rights reserved.
//

import SwiftUI

struct UserCallGridActionButton: View {
    @Binding var isOn: Bool
    var button: ActionButton
    var action: (() -> Void)? = nil
    var onPressDown: (() -> Void)? = nil
    var onPressUp: (() -> Void)? = nil

    @State private var isPressed = false

    private var usesPressHandlers: Bool {
        onPressDown != nil || onPressUp != nil
    }

    var body: some View {
        Text(button.title)
            .font(.subheadline)
            .fontWeight(.bold)
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill((isOn ? Color.gray : Color.accentColor)
                        .opacity(isPressed ? 0.35 : 0.15))
            )
            .foregroundStyle(isOn ? .gray : .accentColor)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        guard !isPressed else { return }
                        isPressed = true
                        onPressDown?()
                    }
                    .onEnded { _ in
                        isPressed = false
                        onPressUp?()
                        if !usesPressHandlers {
                            isOn.toggle()
                            action?()
                        }
                    }
            )
    }
}

struct UserCallActionButton: View {
    @Binding var isOn: Bool
    var button: ActionButton
    var action: (() -> Void)? = nil
    var onPressDown: (() -> Void)? = nil
    var onPressUp: (() -> Void)? = nil

    @State private var isPressed = false

    private var usesPressHandlers: Bool {
        onPressDown != nil || onPressUp != nil
    }

    private var currentTint: Color {
        isOn ? .gray : tintForButton(for: button)
    }

    var body: some View {
        Image(systemName: button.icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 25)
            .padding(15)
            .foregroundStyle(currentTint)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(currentTint.opacity(isPressed ? 0.35 : 0.15))
            )
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        guard !isPressed else { return }
                        isPressed = true
                        onPressDown?()
                    }
                    .onEnded { _ in
                        isPressed = false
                        onPressUp?()
                        if !usesPressHandlers {
                            isOn.toggle()
                            action?()
                        }
                    }
            )
    }

    func tintForButton(for button: ActionButton) -> Color {
        if button.isDestroyStyle {
            return Color.red
        } else if button.isAcceptStyle {
            return Color.green
        } else {
            return Color.accentColor
        }
    }
}
